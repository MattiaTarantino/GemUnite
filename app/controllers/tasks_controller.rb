class TasksController < ApplicationController
  before_action :set_variables, only: %i[ show edit update destroy change_state]
  before_action :is_member?

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @checkpoint = Checkpoint.find(params[:checkpoint_id])
    @project = Project.find(@checkpoint.project_id)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @checkpoint = Checkpoint.find(params[:checkpoint_id])
    @checkpoint.tasks << @task
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_checkpoint_path(project_id: params[:project_id], id: @checkpoint.id), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def change_state
    @task.completato = true
    @task.save
    redirect_to project_checkpoint_path(project_id: @project.id, id: @checkpoint.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variables
      parameter = params[:id] || params[:task_id]
      @task = Task.find(parameter)
      @checkpoint = Checkpoint.find(@task.checkpoint_id)
      @project = Project.find(@checkpoint.project_id)
    end

    def is_member?
      @user_project = UserProject.where(user_id: current_user.id, project_id: params[:project_id]).first
      if @user_project.nil?
        redirect_to my_projects_projects_path
        flash[:notice] = "Non sei membro di questo progetto"
      else
        @role = @user_project.role
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:nome, :descrizione, :completato)
    end
end
