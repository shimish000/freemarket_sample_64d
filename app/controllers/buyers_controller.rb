class BuyersController < ApplicationController
  require 'payjp'
  before_action :set_card, :set_product

  def index
    if @card.blank?
      redirect_to new_user_card_path(current_user.id)
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    Payjp::Charge.create(
      amount: @product.price,
      customer: customer.id, 
      currency: 'jpy',
    )
    redirect_to done_product_buyers_path
  end

  def done
  end

  private
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end