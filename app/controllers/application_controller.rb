class ApplicationController < ActionController::Base
  before_action :set_workshops
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!, :except => [:index]
  # Need to be connect to access at these pages

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :phone_number, :year, :status])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshops
      time = Time.now
      promo = time.to_s(:school_year)
      @workshops = Workshop.where('year = ?', promo)
    end
end
