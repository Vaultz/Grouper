class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user! # Need to be connect to access at these pages
  # GET /workshops
  # GET /workshops.json
  def index
    @workshops = Workshop.all # Useful to display every workshops
    @workshop_last = Workshop.last # Useful to display the last workshop

    if Workshop.count != 0 # If there is no workshop, don't create these variables
      @id_last = @workshop_last.id
      @project = Project.all
    end

  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
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
        format.html { render :new, notice: 'Workshop was successfully created.' }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def addto
    # abort params[:id_group]

      work = Work.new(:user_id => params[:id_user], :project_id => params[:id_group])
      work.save

    redirect_to workshops_url
  end

  def switchto

    # abort params[:id_group_current].inspect
    work = Work.find(params[:id_group_current])
    work.project_id = params[:id_group]
    work.save

    redirect_to workshops_url

  end

  # PATCH/PUT /workshops/1
  # PATCH/PUT /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
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
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to workshops_url, notice: 'Workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_params
      params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
    end
end
