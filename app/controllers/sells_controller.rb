class SellsController < ApplicationController


  def index
  end
  
  def new
    @products = Product.includes(:images).order('created_at DESC')

    @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
         @category_parent_array << parent.name
      end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end


 def get_category_grandchildren
   @category_grandchildren = Category.find(params[:child_id]).children
 end

end

