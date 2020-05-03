class LikesController < ApplicationController
  
  def create
    @like = Like.new(user_id: current_user.id, product_id: params[:product_id])
    unless @like.valid?
      flash.now[:alert] = @like.errors.full_messages
    end
    # binding.pry
    @user_like = Like.create(user_id: current_user.id, product_id: params[:product_id])

    get_product
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    if @like.destroy
    else
      flash.now[:alert] = '削除できませんでした。'
    end
    get_product
  end

  def get_product
    @product = Product.find(params[:product_id])
  end

end
