class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:name])
  end

  def edit
    @customer = current_user
  end

  def update
    customer = current_user
    customer.update(customer_params)
    redirect_to customers_show_path
  end

  def edit
  end

  def check
  end

  def withdraw
    @customer = Customer.find(current_user.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

end
