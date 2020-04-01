class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    Address.create(address_params)
  end
  
  private
  def address_params
    params.require(:address).permit(:first_name, :last_name).merge(user_id:)
  end
end
