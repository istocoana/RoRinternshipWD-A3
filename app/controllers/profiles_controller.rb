class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def show
    @profile = current_user.profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to 'profile/', notice: 'Profile created successfully'
    else
      render :new
    end
  end

  
end
