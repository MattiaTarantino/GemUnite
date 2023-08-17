class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy show_my_project]


  # GET /projects or /projects.json
  def index
=begin
    @all_fields = Field.all.ids
    if params[:field] == nil
      if session[:field] == nil
        @selected_fields = @all_fields
      else
        @selected_fields = session[:field]
      end
    elsif params[:field] != nil
      @selected_fields = params[:field]
    else
      @selected_fields = @all_fields
    end

    base = Project.where(id: FieldsProject.where(field_id: params[:field]).ids)

    base = case params[:sort_by]
             when 'members'
               base.order(dimensione: :desc)
             when 'members_reverse'
               base.order(dimensione: :asc)
             when 'time_posted_reverse'
               base.order(created_at: :asc)
             when 'time_posted'
               base.order(created_at: :desc)
             else
               base.order(created_at: :desc)
           end

    @project = base.all
=end
    @projects = case params[:sort_by]
                when 'members'
                  Project.order(dimensione: :desc)
                when 'members_reverse'
                  Project.order(dimensione: :asc)
                when 'time_posted_reverse'
                  Project.order(created_at: :asc)
                when 'time_posted'
                  Project.order(created_at: :desc)
                else
                  Project.order(created_at: :desc)
                end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @user_project = UserProject.new(user_id: current_user.id, project_id: @project.id, role: "leader")
        @user_project.save
        format.html { redirect_to project_url(@project), notice: "Progetto was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Progetto was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Progetto was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_project

    @project = Project.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :info_leader, :dimensione, :descrizione, :field_id)
    end
  def my_projects
    @user = current_user
    @projects = @user.projects

  end

  def show_my_project

  end


end
