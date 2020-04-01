class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    Address.create(address_params)
  end
  
  private
  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :number, :prefecture_id, :municipality, :address, :building_name, :address_phone).merge(user_id: current_user.id)
  end
end
