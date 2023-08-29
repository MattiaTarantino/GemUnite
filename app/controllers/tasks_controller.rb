class TasksController < ApplicationController
  before_action :set_variables, except: %i[ index new create ]
  before_action :is_member?
  before_action :project_started?, only: %i[ new edit update destroy create change_state ]
  before_action :is_checkpoint_completed?, only: %i[ new edit update destroy create change_state ]

  # GET /tasks or /tasks.json

  def is_checkpoint_completed?
    @checkpoint = Checkpoint.find(params[:checkpoint_id])
    if @checkpoint.completato == true
      redirect_to user_project_checkpoint_path(user_id: @user.id, project_id: @project.id, id: @checkpoint.id), notice: "Checkpoint completato, non puoi effettuare quest'azione"
    end
  end
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @user = current_user
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
    @user = current_user
    @checkpoint = Checkpoint.find(params[:checkpoint_id])
    @checkpoint.tasks << @task
    respond_to do |format|
      if @task.save
        format.html { redirect_to user_project_checkpoint_path(user_id: @user.id, project_id: params[:project_id], id: @checkpoint.id), notice: "Task was successfully created." }
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
    if @task.completato == true
      redirect_to user_project_checkpoint_path(user_id: @user.id, project_id: @project.id, id: @checkpoint.id), notice: "Task già completato"
    end
    @task.completato = true
    @task.save
    redirect_to user_project_checkpoint_path(user_id: @user.id, project_id: @project.id, id: @checkpoint.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variables
      parameter = params[:id] || params[:task_id]
      @task = Task.find(parameter)
      @user = current_user
      @checkpoint = Checkpoint.find(@task.checkpoint_id) || Checkpoint.find(params[:checkpoint_id])
      @project = Project.find(@checkpoint.project_id)
    end

    def is_member?
      @user_project = UserProject.where(user_id: current_user.id, project_id: params[:project_id]).first
      if @user_project.nil?
        redirect_to my_projects_user_projects_path @user
        flash[:notice] = "Non sei membro di questo progetto"
      else
        @role = @user_project.role
      end
    end

    def project_started?
      @project = Project.find(params[:project_id])
      if @project.stato == "aperto"
        redirect_to user_project_show_my_project_path(user_id: @user.id, project_id: @project.id)
        flash[:notice] = "Il progetto non è ancora iniziato"
        return
      end

      if @project.stato == "chiuso"
        redirect_to user_project_show_my_project_path(user_id: @user.id, project_id: @project.id)
        flash[:notice] = "Il progetto è chiuso"
        return
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:nome, :descrizione, :completato)
    end
end
