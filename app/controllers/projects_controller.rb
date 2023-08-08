class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]


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

  # POST /progettos or /progettos.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
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
      params.require(:project).permit(:id, :info_leader, :dimensione, :descrizione, :stato)
    end
  def my_projects
    @user = current_user
    @projects = @user.projects

  end


end
