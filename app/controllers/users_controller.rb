class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /utentes or /utentes.json
  def index
    @users = User.all
  end

  # GET /utentes/1 or /utentes/1.json
  def show
  end

  # GET /utentes/new
  def new
    @user = User.new
  end

  # GET /utentes/1/edit
  def edit
  end

  # POST /utentes or /utentes.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "Utente was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utentes/1 or /utentes/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Utente was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utentes/1 or /utentes/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "Utente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:cognome, :created_at, :id, :mail, :nome, :username)
    end
end
