class ProjectsController < ApplicationController
  before_action :set_project, except: %i[ index new create my_projects ]
  before_action :set_user
  before_action :is_member?, only: %i[ edit update destroy show_my_project ]
  before_action :is_leader?, only: %i[ edit update destroy close_requests close_project ]


  # GET /projects or /projects.json
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
  # GET /progettos or /progettos.json
  def index
=begin
    @all_fields = Field.all.ids
    if params[:field] == nil
      if session[:field] == nil
        @selected_fields = @all_fields
      else
        @selected_fields = session[:field]
      end
    elsif params[:field] != nil
      @selected_fields = params[:field]
    else
      @selected_fields = @all_fields
    end

    base = Project.where(id: FieldsProject.where(field_id: params[:field]).ids)

    base = case params[:sort_by]
             when 'members'
               base.order(dimensione: :desc)
             when 'members_reverse'
               base.order(dimensione: :asc)
             when 'time_posted_reverse'
               base.order(created_at: :asc)
             when 'time_posted'
               base.order(created_at: :desc)
             else
               base.order(created_at: :desc)
           end

    @project = base.all
=end
    @projects = case params[:sort_by]
                when 'members'
                  Project.order(dimensione: :desc)
                when 'members_reverse'
                  Project.order(dimensione: :asc)
                when 'time_posted_reverse'
                  Project.order(created_at: :asc)
                when 'time_posted'
                  Project.order(created_at: :desc)
                else
                  Project.order(created_at: :desc)
                end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
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
    id_ambiti = params[:project][:ambiti].drop(1)
    id_ambiti.each do |ambito|
      @project.fields << Field.find(ambito)
    end

    respond_to do |format|
      if @project.save
        @user_project = UserProject.new(user_id: current_user.id, project_id: @project.id, role: "leader")
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
  def my_projects

  end

  def show_my_project
    @checkpoints = @project.checkpoints
  end




end
