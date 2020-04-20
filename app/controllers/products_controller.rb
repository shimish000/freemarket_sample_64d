class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]
  before_action :set_category, only: [:show]
  before_action :index_category_set, only: :index
  before_action :set_category, only: [:show, :edit]

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
      @product.images.build
      @category_parent_array = ["選択してください"]
      Category.where(ancestry: nil).each do |parent|
          @category_parent_array << parent.name
      end
    else
      redirect_to new_user_session_path
    end
 end  

 def create
    @product = Product.new(product_params)
    if @product.save!
      redirect_to root_path
    else
      redirect_to new_product_path
    end
  end

  def edit
    if user_signed_in? && @product.saler_id == current_user.id
      
      # 親セレクトボックスの初期値(配列)
      @category_parent_array = ["選択してください"]
      # categoriesテーブルから親カテゴリーのみを抽出、配列に格納
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      
      @category_child_array = ["選択してください"]
      @product.category.parent.siblings.each do |child|
        @category_child_array << child.name
      end
      
      @category_grandchild_array = ["選択してください"]
      @product.category.siblings.each do |grandchild|
        @category_grandchild_array << grandchild.name
      end
        
    else
      redirect_to product_path (@product)   
    end
  end


  def update
    if @product.update(product_params)
      redirect_to product_path
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
    category_id=Category.find_by(name:params[:product][:category_id]).id
    params.require(:product).permit(:name, :price, :detail, :brand, :condition_id, :shipping_fee_id, :shipping_date_id, :shipping_s_area_id, images_attributes:  [:image_url, :_destroy, :id]).merge(saler_id: current_user.id, category_id:category_id)
  end

  def set_category
    @grandchild = Category.find("#{@product.category_id}")
    @child = @grandchild.parent
    @parent = @child.parent
  end
  
  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @grandchild = Category.find(@product.category_id)
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
