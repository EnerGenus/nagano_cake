class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses  # 会員が登録した配送先一覧を取得
    @cart_items = current_customer.cart_items
    if @cart_items.empty?
      flash[:notice] = "カートに商品が入っていません"
      redirect_to cart_items_path # カートページ
    else
      render :new # 情報入力ページ
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0" 
      # address_option=0 つまり「お届け先」で「ご自身の住所」を選択している時
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    elsif params[:order][:address_option] == "1" 
      # address_option=1 つまり「お届け先」で「登録済住所から選択」を選択している時
      if params[:order][:address_id].present?
        @address = Address.find_by(id: params[:order][:address_id])
        if @address
          @order.postal_code = @address.postal_code
          @order.address = @address.address
          @order.name = @address.name
        end
      else
        flash[:notice] = "選択された住所が存在しません。"
        redirect_to new_order_path and return
      end
    elsif params[:order][:address_option] == "2"
      if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
        flash.now[:notice] = "新しいお届け先の情報をすべて入力してください。"
        render :new and return
      elsif @order.postal_code !~ /\A\d{7}\z/  # 7桁の数字のみ許可
        flash.now[:notice] = "郵便番号は7桁の数字で入力してください。"
        render :new and return
      end
    end
    # お届け先に「新しいお届け先」が選択されている場合は、view内の記述で格納済み
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @order = Order.new(order_params)
    @order.save!
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
    @order = Order.find(params[:id])
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
