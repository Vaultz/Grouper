class AlertsController < ApplicationController
  def index

  end

  def create
    time = Time.now
    year = time.to_s(:school_year)
    #if we have to choose projects leader we query the database differently
      #Leaders had register with the status equal to 1
      @users = User.where('year = ?', year).shuffle
  end

end
