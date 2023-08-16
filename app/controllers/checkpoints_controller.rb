class CheckpointsController < ApplicationController
  before_action :set_variables, only: %i[ show edit update destroy ]
  before_action :is_member?
  before_action :is_leader?, only: %i[ new edit update destroy  ]


  def is_member?
    @user_project = UserProject.where(user_id: current_user.id, project_id: params[:project_id]).first
    if @user_project.nil?
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei membro di questo progetto"
    else
      @role = @user_project.role
    end
  end

  def is_leader?
    if @user_project.role != "leader"
      redirect_to my_projects_projects_path
      flash[:notice] = "Non sei il leader di questo progetto"
    end
  end
  def index
    @checkpoints = Checkpoint.all
  end

  def show
  end

  def new
    @checkpoint = Checkpoint.new
    @project = Project.find(params[:project_id])
    @user = current_user
  end

  def edit
    @checkpoint = Checkpoint.find(params[:id])
    @tasks = @checkpoint.tasks
  end

  def create
    @checkpoint = Checkpoint.new(checkpoint_params)
    @project = Project.find(params[:project_id])
    @project.checkpoints << @checkpoint
    respond_to do |format|
      if @checkpoint.save
        format.html { redirect_to project_checkpoint_path(project_id: @project.id, id: @checkpoint.id), notice: "Checkpoint was successfully created." }
        format.json { render :show, status: :created, location: @checkpoint }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @checkpoint.destroy

    respond_to do |format|
      format.html { redirect_to project_show_my_project_path(project_id: @project.id), notice: "Checkpoint was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @checkpoint.update(checkpoint_params)
        format.html { redirect_to project_checkpoint_path(project_id: @project.id, id: @checkpoint.id), notice: "Progetto was successfully updated." }
        format.json { render :show, status: :ok, location: @checkpoint }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checkpoint.errors, status: :unprocessable_entity }
      end
    end
  end


  def set_variables
    @user = current_user
    @checkpoint = Checkpoint.find(params[:id])
    @tasks = @checkpoint.tasks
    @project = Project.find(@checkpoint.project_id)
    @role = UserProject.where(user_id: current_user.id, project_id: @project.id).first.role
  end

  private

    def checkpoint_params
      params.require(:checkpoint).permit(:nome, :descrizione, :completato)
    end


end
