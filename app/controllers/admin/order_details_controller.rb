class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_detail.all
    is_updated = true

    if @order_detail.update(order_detail_params)
      @order.update(status: "in_production") if @order_detail.making_status == "making"
      @order_details.each do |order_detail|
          if order_detail.making_status != "complete"
            is_updated = false
          end
      end
      @order.update(status: "preparing_for_shipment") if is_updated
    end
       redirect_to admin_order_path(@order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
