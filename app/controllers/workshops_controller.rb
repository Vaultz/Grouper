class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user! # Need to be connect to access at these pages
  # GET /workshops
  # GET /workshops.json
  def index
    # @workshop = @workshops.last # Useful to display the last workshop
    # if @workshops.count != 0 # If there is no workshop, don't create these variables
    #   @id = @workshop.id
    #   @project = @workshop.projects
    #   @count = count_groups(@project)
    # end
    # render :show

  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    if @workshops.count != 0 # If there is no workshop, don't create these variables
      @id = @workshop.id
      @projects = @workshop.projects
      if current_user.projects.find_by(workshop_id: @id)
        @current_project_id = current_user.projects.find_by(workshop_id: @id).id
      else
        @current_project_id = nil
      end

    end
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
    if session[:workshop_data]
      respond_to do |format|
          format.html { render :edit }
      end
    end


  end


  def create
    @workshop = Workshop.new(workshop_params)
    @workshop.user_id = current_user.id # Give the current user id at the new workshop

    respond_to do |format|
      if @workshop.save
        format.html { render :new, notice: I18n.t('views.workshop.flash_messages.workshop_was_successfully_created') }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def addto



    current_user.projects << Project.find(params[:id_project])
    # @params_user=User.find(current_user)
    # @params_projet=Project.find(params[:id_group])
    #
    # @params_projet.works.create(user: @params_user)

    redirect_to workshop_path(params[:id_workshop])

  end

  def switchto


    current_user.projects.delete(Project.find(params[:id_old_project]))
    current_user.projects << Project.find(params[:id_project])
    # @params_user=User.find(current_user)
    # @params_projet=Project.find(params[:id_group])
    # @work = Work.find(params[:id_group_current])
    # @work.destroy
    # @params_projet.works.create(user: @params_user)
    # work.project_id = params[:id_group]
    # work.save

    redirect_to workshop_path(params[:id_workshop])

  end


  # PATCH/PUT /workshops/1
  # PATCH/PUT /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop.to_param, notice: I18n.t('views.workshop.flash_messages.workshop_was_successfully_updated') }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    if session[:workshop_unfinished] == @workshop.id
      session.delete(:workshop_unfinished)
    end
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to workshops_url, notice: I18n.t('views.workshop.flash_messages.workshop_was_successfully_deleted') }
      format.json { head :no_content }
    end
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      if params[:id]
        @workshop = @workshops.friendly.find(params[:id])
      else
        @workshop = @workshops.first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_params
      params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
    end
    def workshop_id
      params[:id]
    end
end
