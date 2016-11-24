class LiensController < ApplicationController
  before_action :set_lien, only: [:show, :edit, :update, :destroy]

  # GET /liens
  # GET /liens.json
  def index
    time = Time.now
    year = time.to_s(:school_year)
    @liens = Lien.where('year = ? ', year)
  end

  # GET /liens/1
  # GET /liens/1.json
  def show
  end

  # GET /liens/new
  def new
    @lien = Lien.new
  end

  # GET /liens/1/edit
  def edit
  end

  # POST /liens
  # POST /liens.json
  def create
    @lien = Lien.new(lien_params)
    time = Time.now
    year = time.to_s(:school_year)
    @lien.year = year

    if /facebook/ =~ lien_params[:url]
      @lien.logo='facebook.png'
    elsif /twitter/ =~ lien_params[:url]
      @lien.logo='twitter.png'
    elsif /github/ =~ lien_params[:url]
      @lien.logo='github.png'
    elsif /gitter/ =~ lien_params[:url]
      @lien.logo='gitter.png'
    elsif /ppulse/ =~ lien_params[:url]
      @lien.logo='ppulse.png'
    elsif /slack/ =~ lien_params[:url]
      @lien.logo='slack.png'
    elsif /docs.google/ =~ lien_params[:url]
      @lien.logo='doc.png'
    elsif /drive.google/ =~ lien_params[:url]
      @lien.logo='googledrive.png'
    elsif /framapad/ =~ lien_params[:url]
      @lien.logo='framapad.png'
    end

    respond_to do |format|
      if @lien.save
        format.html { redirect_to @lien, notice: 'Le lien a été ajouté avec succès.' }
        format.json { render :show, status: :created, location: @lien }
      else
        format.html { render :new }
        format.json { render json: @lien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /liens/1
  # PATCH/PUT /liens/1.json
  def update
    respond_to do |format|
      if @lien.update(lien_params)
        format.html { redirect_to @lien, notice: 'Le lien a été mis à jour.' }
        format.json { render :show, status: :ok, location: @lien }
      else
        format.html { render :edit }
        format.json { render json: @lien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liens/1
  # DELETE /liens/1.json
  def destroy
    @lien.destroy
    respond_to do |format|
      format.html { redirect_to liens_url, notice: 'Le lien a été supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lien
      @lien = Lien.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lien_params
      params.require(:lien).permit(:name, :url)
    end
end
