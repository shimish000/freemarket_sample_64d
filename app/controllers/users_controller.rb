class UsersController < ApplicationController
  
  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    user = User.find(show_params[:id])
  end


  def destroy
    @parents = Category.where(ancestry: nil)
  end



end
