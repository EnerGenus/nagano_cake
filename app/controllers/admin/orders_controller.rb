class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_detail
    @customer_name = @order.customer.family_name + @order.customer.first_name
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_detail
        if  @order.update(order_params)
      @order_details.update_all(making_status: "wait") if @order.status == "payment_confirmed"
    end
      redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
