class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all 
    @items = Item.where(is_active: true).order(created_at: "DESC").limit(4)
  end

  def about
  end
end
