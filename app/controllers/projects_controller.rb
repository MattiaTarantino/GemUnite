class ProjectsController < ApplicationController
  before_action :set_project, except: %i[ index new create my_projects ]
  before_action :set_user
  before_action :is_member?, only: %i[ edit update destroy show_my_project ]
  before_action :is_leader?, only: %i[ edit update destroy close_requests close_project ]


  def is_member?
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.nil?
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei membro di questo progetto"
    else
      @role = @user_project.role
    end
  end

  def is_leader?
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.role != "leader"
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei il leader di questo progetto"
    end
  end

  # GET /projects or /projects.json
  def index

    @all_fields = Field.all.ids

    if !params[:filter_by].present?
      if !session[:filter_by].present?
        @selected_fields = @all_fields
      else
        if session[:filter_by] == "all"
          @selected_fields = @all_fields
        else
          @selected_fields = session[:filter_by]
        end
      end
    elsif params[:filter_by].present?
      if params[:filter_by] == "all"
        @selected_fields = @all_fields
      else
      @selected_fields = params[:filter_by]
      end
    else
      @selected_fields = @all_fields
    end


    session[:filter_by] = @selected_fields

    base = Project.joins(:fields).where(fields: {id: @selected_fields}).distinct

    sorting = params[:sort_by] || session[:sort_by]

    base = case sorting
                when 'members'
                  base.joins(:user_projects).group('projects.id').order('COUNT(user_projects.id)')
                when 'members_reverse'
                  base.joins(:user_projects).group('projects.id').order('COUNT(user_projects.id) DESC')
                when 'time_posted_reverse'
                  base.order(created_at: :asc)
                when 'time_posted'
                  base.order(created_at: :desc)
                else
                  base.order(created_at: :desc)
                end
    session[:sort_by] = sorting
    @projects = base.all

  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
    @fields = Field.all
  end

  # GET /projects/1/edit
  def edit
    @fields = @project.fields
  end

  def create
    parameters = project_params.except(:ambiti)
    @project = Project.new(parameters)
    id_ambiti = params[:project][:field_id].drop(1)
    id_ambiti.each do |ambito|
      @project.fields << Field.find(ambito)
    end


    respond_to do |format|
      if @project.save
        @user_project = UserProject.new(user_id: current_user.id, project_id: @project.id, role: "leader")
        @chat = Chat.new(project_id: @project.id)
        @chat.save
        @user_project.save
        format.html { redirect_to project_url(@project), notice: "Progetto was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      parameters = project_params.except(:ambiti)
      id_ambiti = params[:project][:ambiti].drop(1)
      if @project.update(parameters)
        id_ambiti.each do |ambito|
          field = Field.find(ambito)
          if not @project.fields.include? field
            @project.fields << field
          end
        end
        @project.fields.each do |field|
          if not id_ambiti.include? field.id.to_s
            @project.fields.delete(field)
          end
        end
        format.html { redirect_to project_url(@project), notice: "Progetto was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Progetto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def close_requests
    @requests = Request.where(project_id: @project.id)
    @requests.each do |request|
      request.destroy
    end
    @project.stato = "iniziato"
    @project.save!
    redirect_to project_show_my_project_path(@project)
  end

  def close_project
    @project.stato = "chiuso"
    @project.save!
    redirect_to my_projects_projects_path
  end

  def my_projects
  end

  def show_my_project
    @checkpoints = @project.checkpoints
    @chat = @project.chat # attenzione che alcuni non ce l'hanno
    @messages = @chat.messages
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
    @projects_member = []
    UserProject.where(user_id: @user.id, role: "member").each do |user_project|
      @projects_member << Project.find(user_project.project_id)
    end

    @projects_leader = []
    UserProject.where(user_id: @user.id, role: "leader").each do |user_project|
      @projects_leader << Project.find(user_project.project_id)
    end
  end

  def set_project
    project_id = params[:project_id]
    project_id ||= params[:id] # se nella uri l'id del progetto è passato in params[:id] anziché in params[:project_id]
    @project = Project.find(project_id)
  end


    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :info_leader, :dimensione, :descrizione, :ambiti => [])
    end





end
