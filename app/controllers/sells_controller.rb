class SellsController < ApplicationController

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end
  

  def new
    @product = Product.new
    @product.images.new
  end
  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def product_params
    params.require(:product).permit(:name, :price, images_attributes: [:src])
  end


  def edit
  end


  def update
  end


  def destroy
  end

end
