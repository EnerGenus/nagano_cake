class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
    unless @address.customer.id == current_customer.id
      redirect_to addresses_path
    end
  end

  def create
    @addresses = Address.where(customer_id: current_customer.id)
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to request.referer
    else
      render :index
    end

  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
