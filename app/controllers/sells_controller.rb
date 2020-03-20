class SellsController < ApplicationController

  def index
  end
  
  def new
    @products = Product.includes(:images).order('created_at DESC')
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
