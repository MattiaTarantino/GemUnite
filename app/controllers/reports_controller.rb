class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end


  def new
    @user = current_user
    @report = Report.new
  end

  def create
    @user = current_user
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to user_reports_path @user, notice: 'Segnalazione creata correttamente.'
    else
      render 'new', notice: 'Errore nella creazione della segnalazione.'
    end
  end

  private

    def report_params
      params.require(:report).permit(:descrizione)
    end

end
