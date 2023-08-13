class CheckpointsController < InheritedResources::Base

  def edit
    @checkpoint = Checkpoint.find(params[:id])
    @tasks = @checkpoint.tasks
  end


  private

    def checkpoint_params
      params.require(:checkpoint).permit(:nome, :descrizione, :completato)
    end


end
