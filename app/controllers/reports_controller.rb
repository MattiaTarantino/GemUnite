class ReportsController < ApplicationController

  private

    def report_params
      params.require(:report).permit(:descrizione)
    end

end
