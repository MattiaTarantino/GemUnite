class ProjectsController < ApplicationController
  before_action :set_project, except: %i[ index new create my_projects ]
  before_action :set_user
  before_action :is_member?, only: %i[ edit update destroy show_my_project ]
  before_action :is_leader?, only: %i[ edit update destroy close_requests close_project espelli_membro open_github ]


  def is_member?
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.nil?
      redirect_to my_projects_user_projects_path @user
      flash[:notice] = "Non sei membro di questo progetto"
    else
      @role = @user_project.role
    end
  end

  def is_leader?
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.nil?
      redirect_to my_projects_user_projects_path @user
      flash[:notice] = "Non sei membro di questo progetto"
    end
    if @user_project.role != "leader"
      redirect_to my_projects_user_projects_path @user
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

    @sorting = params[:sort_by] || session[:sort_by]

    base = case @sorting
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
    session[:sort_by] = @sorting
    @projects = base.all

  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.find(params[:id])
    @members = @project.user_projects.map(&:user)
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
    if params[:field_ids].present?
      selected_field_ids = params[:field_ids].reject(&:blank?)
    else
      redirect_to new_user_project_path @user, notice: "Devi selezionare almeno un ambito"
      return
    end
    parameters = project_params.except(:field_ids)
    @project = Project.new(parameters)
    @project.fields = Field.where(id: selected_field_ids)


    respond_to do |format|
      if @project.save
        @user_project = UserProject.new(user_id: current_user.id, project_id: @project.id, role: "leader")
        @chat = Chat.new(project_id: @project.id)
        @chat.save
        @user_project.save
        @project.chat = @chat
        format.html { redirect_to user_project_path(@user, @project), notice: "Progetto was successfully created." }
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
      if params[:field_ids].present?
        selected_field_ids = params[:field_ids].reject(&:blank?)
      else
        redirect_to edit_user_project_path @user, notice: "Devi selezionare almeno un ambito"
        return
      end
      parameters = project_params.except(:field_ids)
      if @project.update(parameters)
        @project.fields = Field.where(id: selected_field_ids)
        format.html { redirect_to user_project_path(@user, @project), notice: "Progetto was successfully updated." }
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
    redirect_to user_project_show_my_project_path(@user, @project)
  end

  def close_project
    @project.stato = "chiuso"
    @project.save!
    redirect_to my_projects_user_projects_path @user
  end

  def my_projects
  end

  def open_github
    if !session["access_token"].present?
      redirect_to users_projects_show_my_project_path(@user, @project), notice: "Non sei loggato su github"
      return
    end
    if not @project.github_link.present?
      # Provide authentication credentials
      client = Octokit::Client.new(:access_token => session["access_token"])
      repo_name = @project.name
      repo_description = @project.descrizione

      begin
        response = client.create_repository(repo_name, description: repo_description)
        repo_url = response.html_url
        Rails.logger.debug "Repository creata correttamente: #{repo_url}"
        @project.github_link = repo_url
        @project.save!
        redirect_to user_project_show_my_project_path(@user, @project), notice: "Repository creata correttamente"
        return
      rescue Octokit::Error => e
        Rails.logger.debug "Errore creazione repository: #{e.message}"
        redirect_to user_project_show_my_project_path(@user, @project), notice: "La repository non è stata creata correttamente"
      end
    else
      redirect_to user_project_show_my_project_path(@user, @project), notice: "Il progetto ha già un link a github"
    end
  end

  def show_my_project
    @checkpoints = @project.checkpoints
    @members = @project.users
    @chat = @project.chat
    @messages = @chat.messages
    if @project.github_link.present?
      @github_link = @project.github_link
    end
  end

  def espelli_membro
    if (@project.stato == "chiuso")
      redirect_to user_project_show_my_project_path(@user, @project), notice: "Non puoi espellere un membro da un progetto chiuso"
      return
    end
    @user_project = UserProject.find_by(user_id: params[:member_id], project_id: @project.id)
    if @user_project
      @user_project.destroy
    end
    redirect_to user_project_show_my_project_path(@user, @project)
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
