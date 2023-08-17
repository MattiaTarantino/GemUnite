class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]
  before_action :set
  before_action :is_leader?, only: %i[ show edit update destroy accept decline ]

  def set
    @project = Project.find(params[:project_id])
    @user = current_user
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
  end

  def is_leader?
    if @user_project.role != "leader"
      redirect_to root_path
      flash[:notice] = "Solo il leader del progetto può accedere a questa pagina"
    end
  end

  # GET /requests or /requests.json
  def index
    @requests = @project.requests
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to request_url(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def accept
    @request = Request.find(params[:request_id])
    @request.update(stato_accettazione: "accettata")
    UserProject.create(user_id: @user.id, project_id: @project.id)
    redirect_to project_requests_path(project_id: @project.id), notice: "Richiesta accettata"
  end

  def decline
    @request = Request.find(params[:request_id])
    @request.update(stato_accettazione: "rifiutata")
    redirect_to project_requests_path(project_id: @project.id), notice: "Richiesta rifiutata"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:request_id, :note, :stato_accettazione)
    end
end
