class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]
  before_action :set_category, only: [:show]
  before_action :index_category_set, only: :index

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.where(ancestry: nil)
  end
  
  def show
    @parents = Category.where(ancestry: nil)
    @category = @product.category
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
      redirect_to new_user_session_path
    end
 end
  
  
    

 def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path
    end
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
    if @product.destroy
      redirect_to root_path
    else
      render :edit
    end
  end
  

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  private
  
  def product_params
    params.require(:product).permit(:name, :price, :detail, :condition_id, :brand, :category_id, :shipping_fee_id, :shipping_date_id, :shipping_s_area_id, images_attributes:  [:image_url, :_destroy, :id]).merge(saler_id: current_user.id)
  end
  
  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @grandchild = Category.find("#{@product.category_id}")
    @child = @grandchild.parent
    @parent = @child.parent
  end


  def index_category_set
    array = [1, 2, 3, 4]
      for num in array do
        search_anc = Category.where('ancestry LIKE(?)', "#{num}/%")
        ids = []
        search_anc.each do |i|
          ids << i[:id]
        end
        products = Product.where(category_id: ids).order("id DESC").limit(10)
        instance_variable_set("@cat_no#{num}", products)
      end
   end
end
