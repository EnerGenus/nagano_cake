class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8)
    @all_items = Item.where(is_active: true)
    @genres = Genre.all 
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all 
  end
end
