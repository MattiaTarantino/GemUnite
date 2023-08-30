class RequestsController < ApplicationController
  before_action :set_request, except: %i[ index new create my_requests ]
  before_action :set, except: %i{ my_requests }
  before_action :is_leader?, only: %i[ show edit update destroy accept decline ]
  before_action :is_project_open?, except: %i[ index new create my_requests ]
  before_action :is_owner?, only: %i[ show edit update ]

  def set
    @project = Project.find(params[:project_id])
    @user = current_user
    @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
  end

  def is_leader?
    if @user_project && @user_project.role != "leader"
      redirect_to root_path
      flash[:notice] = "Solo il leader del progetto può accedere a questa pagina"
    end
  end

  def is_owner?
    if @user.id != @request.user_id
      redirect_to root_path
      flash[:notice] = "Non puoi accedere a questa richiesta"
    end
  end

  def is_project_open?
    if @project.stato != "aperto"
      redirect_to root_path
      flash[:notice] = "Le richieste di questo progetto sono chiuse"
    end
  end

  # GET /requests or /requests.json
  def index
    if @user_project && @user_project.role == "leader"
      @requests = @project.requests.where(stato_accettazione: "In attesa")
      @owner = false
    else
      redirect_to root_path
      flash[:notice] = "Solo il leader del progetto può accedere a questa pagina"
    end
  end

  # GET /requests/1 or /requests/1.json
  def show
    @request = Request.find(params[:id])
    if @user.id == @request.user_id
      @owner = true
    end
  end

  def my_requests
    @requests = Request.where(user_id: current_user.id)
  end

  # GET /requests/new
  def new
    @project = Project.where(id: params[:project_id]).first
    if UserProject.where(user_id: current_user.id, project_id: @project.id).first
      redirect_to root_path, notice: "Fai già parte di questo progetto"
    end
    @request = Request.new
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
        format.html { redirect_to user_project_request_path(user_id: @user.id, project_id: @project_id, id: @request.id), notice: "Request was successfully created." }
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
        format.html { redirect_to user_project_request_path(user_id: @user.id, project_id: @project_id, id: @request.id), notice: "Request was successfully updated." }
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
      format.html { redirect_to my_requests_user_requests_path @user, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def accept
    @request = Request.find(params[:request_id])
    @request.update(stato_accettazione: "Accettata")
    if UserProject.where(user_id: @request.user.id, project_id: @project.id).first
      redirect_to user_project_requests_path(user_id: @user.id,project_id: @project.id), notice: "L'utente fa già parte del progetto"
    else
      UserProject.create(user_id: @request.user_id, project_id: @project.id)
      redirect_to user_project_requests_path(user_id: @user.id,project_id: @project.id), notice: "Richiesta accettata"
    end
  end

  def decline
    @request = Request.find(params[:request_id])
    @request.update(stato_accettazione: "Rifiutata")
    redirect_to user_project_requests_path(user_id: @user.id,project_id: @project.id), notice: "Richiesta rifiutata"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @project = Project.find(params[:project_id])
    parameter = params[:id] || params[:request_id]
    @request = Request.find(parameter)
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:request_id, :note, :stato_accettazione)
  end
end
