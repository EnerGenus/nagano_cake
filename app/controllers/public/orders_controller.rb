class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all  # 会員が登録した配送先一覧を取得
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0" 
      # address_option=0 つまり「お届け先」で「ご自身の住所」を選択している時
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    elsif params[:order][:address_option] == "1" 
      # address_option=0 つまり「お届け先」で「登録済住所から選択」を選択している時
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    # お届け先に「新しいお届け先」が選択されている場合は、view内の記述で格納済み
  end

  def create
  end

  def done
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(
      :payment_method,
      :postal_code,
      :address,
      :name
    )
  end
end
