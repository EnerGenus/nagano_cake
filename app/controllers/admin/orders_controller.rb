class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all # 仮
    @order_details
  end

  def update
    @order.update(order_params)
    redirext_to admin_order_path(@order), notice:"注文ステータスを更新しました"
  end


  private


end
