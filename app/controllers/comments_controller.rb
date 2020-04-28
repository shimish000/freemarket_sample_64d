class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    if @comment.save!
      redirect_back(fallback_location: product_path(@product))
    else 
      redirect_to root_path
    end
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end

end
