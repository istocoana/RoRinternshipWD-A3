class UsersController < ApplicationController

  def destroy
    @user = User.find(params[:id])

    @user.orders.destroy_all
    
    if @user.destroy
      flash[:notice] = "User and associated orders deleted successfully."
    else
      flash[:alert] = "User deletion failed."
      raise ActiveRecord::Rollback
    end
  
    redirect_to users_path
  end

end
