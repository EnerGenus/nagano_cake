class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    flash[:notice] = "個数を変更しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "選択した商品を削除しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    destroy_all = CartItem.where(customer_id: current_customer.id)
    destroy_all.destroy_all
    flash[:notice] = "カートの中身を空にしました"
    redirect_back(fallback_location: root_path)
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = cart_item_params[:item_id]
    if check_cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
      check_cart_item.amount += params[:cart_item][:amount].to_i
      check_cart_item.update(amount: @cart_item.amount)
      flash[:notice] = "すでにカートに存在している商品です"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:notice] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:notice] = "個数を選択してください"
        @item = Item.find(params[:cart_item][:item_id])

        render "public/items/show"
      end
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
