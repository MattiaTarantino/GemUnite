class CheckpointsController < ApplicationController
  before_action :set_variables, only: %i[ show edit ]
  def index
    @checkpoints = Checkpoint.all
  end

  def show
  end

  def new
    @checkpoint = Checkpoint.new
    @project = Project.find(params[:project_id])
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

  def set_variables
    @checkpoint = Checkpoint.find(params[:id])
    @tasks = @checkpoint.tasks
    @project = Project.find(@checkpoint.project_id)
  end

  private

    def checkpoint_params
      params.require(:checkpoint).permit(:nome, :descrizione, :completato)
    end


end
