class ProgettosController < ApplicationController
  before_action :set_progetto, only: %i[ show edit update destroy ]

  # GET /progettos or /progettos.json
  def index
    @progettos = Progetto.all
  end

  # GET /progettos/1 or /progettos/1.json
  def show
  end

  # GET /progettos/new
  def new
    @progetto = Progetto.new
  end

  # GET /progettos/1/edit
  def edit
  end

  # POST /progettos or /progettos.json
  def create
    @progetto = Progetto.new(progetto_params)

    respond_to do |format|
      if @progetto.save
        format.html { redirect_to progetto_url(@progetto), notice: "Progetto was successfully created." }
        format.json { render :show, status: :created, location: @progetto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @progetto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progettos/1 or /progettos/1.json
  def update
    respond_to do |format|
      if @progetto.update(progetto_params)
        format.html { redirect_to progetto_url(@progetto), notice: "Progetto was successfully updated." }
        format.json { render :show, status: :ok, location: @progetto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @progetto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progettos/1 or /progettos/1.json
  def destroy
    @progetto.destroy

    respond_to do |format|
      format.html { redirect_to progettos_url, notice: "Progetto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progetto
      @progetto = Progetto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def progetto_params
      params.require(:progetto).permit(:id_progetto, :info_leader, :dimensione, :descrizione, :stato)
    end
end
