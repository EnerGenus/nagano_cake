class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_member.addresses.all  # 会員が登録した配送先一覧を取得
  end

  def confirm
  end

  def create
  end

  def done
  end

  def index
  end

  def show
  end


end
