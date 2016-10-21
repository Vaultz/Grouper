class PromoController < ApplicationController
  def index
    time = Time.now
    @year = time.to_s(:school_year)
    @user_promo = User.where('year = ?', @year)
  end
end
