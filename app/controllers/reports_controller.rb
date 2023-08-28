class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end


  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to reports_path, notice: 'Segnalazione creata correttamente.'
    else
      render 'new', notice: 'Errore nella creazione della segnalazione.'
    end
  end

  private

    def report_params
      params.require(:report).permit(:descrizione)
    end

end
