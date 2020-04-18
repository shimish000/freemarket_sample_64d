class CategoriesController < ApplicationController
  def index 
    @parents = Category.where(ancestry: nil)
  end
  def new
    @parents = Category.where(ancestry: nil)
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end
end
