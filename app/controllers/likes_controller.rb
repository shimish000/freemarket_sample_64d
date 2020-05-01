class LikesController < ApplicationController
  
  def create
    @like = Like.create(user_id: current_user.id, product_id: params[:product_id]
    # @like.save!
    # if @like.save！
    # else
    #   flash.now[:alert] = @like.errors.full_messages
    # end
    @likes = Like.where(product_id: params[:product_id])
    get_product
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    @like.destroy
    # if @like.destroy
    # else
    #   flash.now[:alert] = '削除できませんでした。'
    # end
    @likes = Like.where(product_id: params[:product_id])
    get_product
  end

  def get_product
    @product = Product.find(params[:product_id])
  end

end
