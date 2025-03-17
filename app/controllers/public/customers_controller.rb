class Public::CustomersController < ApplicationController
  
  def show
  end

  def edit
  end

  def check
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
end
