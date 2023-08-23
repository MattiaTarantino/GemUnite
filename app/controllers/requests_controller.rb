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
    if @user_project && @user_project.role == "leader"
      @requests = @project.requests.where(stato_accettazione: "aperta")
    else
      redirect_to root_path
      flash[:notice] = "Solo il leader del progetto può accedere a questa pagina"
    end
  end
  # GET /requests/1 or /requests/1.json
  def show
  end

  def my_requests
    @requests = Request.where(user_id: current_user.id)
  end

  # GET /requests/new
  def new
    @request = Request.new
    @project = Project.where(id: params[:project_id]).first
  end

  # GET /requests/1/edit
  def edit
    @request = Request.where(id: params[:id]).first
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    @project_id = params[:project_id]
    @request.project_id = @project_id
    @request.user_id = current_user.id
    @request.stato_accettazione = "In attesa"

    respond_to do |format|
      if @request.save
        format.html { redirect_to project_request_path(project_id: @project_id, id: @request.id), notice: "Request was successfully created." }
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
        format.html { redirect_to project_request_path(project_id: @project_id, id: @request.id), notice: "Request was successfully updated." }
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
      format.html { redirect_to my_requests_requests_path, notice: "Request was successfully destroyed." }
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
      @project = Project.find(params[:project_id])
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:request_id, :note, :stato_accettazione)
    end
end
