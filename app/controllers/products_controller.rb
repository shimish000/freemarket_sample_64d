class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.where(ancestry: nil)
  end
  
  def show

  end


  def new
    if user_signed_in?
      @product = Product.new
      @product.images.new
      @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
          @category_parent_array << parent.name
      end
    else
      redirect_to new_user_registration_path
    end
 end
  
  
    

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
    redirect_to root_path
  end

  def edit
  end


  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  private
  
  def product_params
    params.require(:product).permit(:name, :price, images_attributes:  [:src, :_destroy, :id])
  end
  
  def set_product
    @product = Product.find(params[:id])
  end



end
