class CheckpointsController < InheritedResources::Base

  private

    def checkpoint_params
      params.require(:checkpoint).permit(:nome, :descrizione, :completato)
    end

end
