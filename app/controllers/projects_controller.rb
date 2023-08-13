class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy show_my_project]


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
  end

  # GET /progettos/1/edit
  def edit
  end

  def create
    @project = Project.new(project_params)

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
      params.require(:project).permit(:name, :info_leader, :dimensione, :descrizione)
    end
  def my_projects
    @user = current_user
    @projects = @user.projects

  end

  def show_my_project
    @checkpoints = @project.checkpoints

  end


end
