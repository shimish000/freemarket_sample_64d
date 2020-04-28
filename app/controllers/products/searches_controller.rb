class Products::SearchesController < ApplicationController
  def index
    @products = Product.search(params[:keyword])
    @parents = Category.where(ancestry: nil)
  end
end
