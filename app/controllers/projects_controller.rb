class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ edit update destroy show_my_project]
  before_action :set_user, only: %i[ edit update destroy my_projects show_my_project ]
  before_action :is_member?, only: %i[ edit update destroy show_my_project ]
  before_action :is_leader?, only: %i[ edit update destroy ]


  def is_member?
    @user = current_user
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.nil?
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei membro di questo progetto"
    end
  end

  def is_leader?
    if @user_project.role != "leader"
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei il leader di questo progetto"
    end
  end
  # GET /progettos or /progettos.json
  def index
    @projects = Project.all
  end

  # GET /progettos/1 or /progettos/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /progettos/new
  def new
    @project = Project.new
    @fields = Field.all
  end

  # GET /progettos/1/edit
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

  # PATCH/PUT /progettos/1 or /progettos/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Progetto was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progettos/1 or /progettos/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Progetto was successfully destroyed." }
      format.json { head :no_content }
    end
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
  end


end
