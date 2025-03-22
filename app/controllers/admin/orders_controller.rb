class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all # 仮
    @order_details
  end

  def update_order
    @order.update(order_params)
    redirect_to admin_order_path(@order), notice:"注文ステータスを更新しました"
  end

  def update_item
    @order_detail.update(order_detail_params)
    ridirext_to admin_order_path()
  end


  private


end
