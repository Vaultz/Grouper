class PromoController < ApplicationController
  def index

    @user_promo = User.where('year = ?', @promo)
    unless @user_promo.any?
      render file: "#{Rails.root}/public/404.html" , status: :not_found
    end
  end
end
