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
    @cart_items = CartItem.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      # カート内の商品を OrderDetail に保存
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(
          order_id: @order.id,
          item_id: cart_item.item.id,
          price_including_tax: cart_item.item.with_tax_price,
          amount_ordered: cart_item.amount,
          making_status: 0  # デフォルトの製作ステータス
        )
        order_detail.save
      end
  
      # カートを空にする
      current_customer.cart_items.destroy_all
  
      # 注文完了ページへリダイレクト
      redirect_to orders_done_path
    else
      render :confirm
    end
  end

  def done
  end

  def index
      @orders = Order.where(customer_id: current_customer.id)
  end

  def edit
  end

  def update
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(
      :customer_id,
      :shipping_cost,
      :total_payment,
      :status,
      :payment_method,
      :postal_code,
      :address,
      :name
    ).merge(status: params[:order][:status].to_i)
  end
end
