class LikesController < ApplicationController
  before_action :get_product, only: [:create,:destroy]

  def create
    @like = Like.create(user_id: current_user.id, product_id: params[:product_id])
    @likes = Like.where(product_id: params[:product_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    @like.destroy
    @likes = Like.where(product_id: params[:product_id])
  end

  private
  def get_product
    @product = Product.find(params[:product_id])
  end
end
