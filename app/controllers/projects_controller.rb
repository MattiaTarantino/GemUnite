class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :is_member?, only: %i[ project_home ]

  def is_member?
    @project = Project.find(params[:project_id])
    @user = current_user
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
    if @user_project.nil?
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei membro di questo progetto"
    end
  end

  # GET /progettos or /progettos.json
  def index
    @projects = Project.all
  end

  # GET /progettos/1 or /progettos/1.json
  def show
  end

  # GET /progettos/new
  def new
    @project = Project.new
    @fields = Field.all
  end

  # GET /progettos/1/edit
  def edit
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
  def set_project

    @project = Project.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :info_leader, :dimensione, :descrizione, :ambiti => [])
    end

  def my_projects
    @user = current_user
    @projects = @user.projects

  end

  def project_home
    @project = Project.find(params[:project_id])
    @user = current_user
  end


end
