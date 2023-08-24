class ProfilesController < ApplicationController

  def new
    @profile = current_user.profile || current_user.build_profile
  end

  def create
    @profile = current_user.profile || current_user.build_profile(profile_params)

    if @profile.save
      redirect_to user_profile_path, notice: 'Profile created successfully.'
    else
      render :new
    end
  end

  def show
    @user = current_user
    @profile = current_user.profile
    @orders = current_user.orders
    unless @profile
      redirect_to new_profile_path, alert: "Please complete your profile first."
    end
  end

  def edit
    @profile = current_user.profile
  end
  
  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end
  
  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone, :street_address, :city, :county)
  end
end
