class ToppagesController < ApplicationController
  
  def index
    @star_shops = Shop.all.each do |shop|
      shop.average = shop.average_score
    end
    @star_shops = @star_shops.sort_by { |shop| shop.average }.reverse
    @star_shops = @star_shops.slice(0, 4) 
   
    @reviews = Review.order(id: :desc).limit(5)
  end
end
