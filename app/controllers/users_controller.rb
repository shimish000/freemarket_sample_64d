class UsersController < ApplicationController
  
  def index
  end

  def show
    user = User.find(show_params[:id])
  end


  def destroy
  end



end
