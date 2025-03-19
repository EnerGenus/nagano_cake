class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to request.referer, notice: '配送先を登録しました'
    else
      @addresses = current_customer.addresses
      @address = Address.new
      flash.now[:alert] = "配送先の登録に失敗しました。" 
      render :index
    end

  end

  def update

  end

  def destroy

  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
