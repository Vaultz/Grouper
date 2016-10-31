class PromoController < ApplicationController
  def index
    @user_promo = User.where('year = ?', @promo)
  end
end
