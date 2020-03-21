class ProductsController < ApplicationController

  def index
    @parents = Category.all.where(ancestry: nil)
  end
  
  def show

  end



 
end
