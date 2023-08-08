class FieldsController < InheritedResources::Base

  private

    def field_params
      params.require(:field).permit(:nome)
    end

end
