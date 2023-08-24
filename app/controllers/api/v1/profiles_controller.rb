class Api::V1::ProfilesController < Api::V1::ApplicationController
  before_action :authenticate_user!

  def new
    if user_signed_in?
      @profile = current_user.build_profile(profile_params)
      
      if @profile.save
        render json: @profile, status: :created
      else
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Authentication error' }, status: :unauthorized
    end
  end

  def show
    @profile = current_user.profile
    render json: @profile
  end

  def edit
    @profile = current_user.profile
    render json: @profile
  end
  
  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_api_v1_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end
  
  private

  def profile_params
    params.permit(:first_name, :last_name, :phone, :street_address, :city, :county)
  end

  def respond_with_success
    render json: {
      status: { code: 200, message: "Profile created successfully." },
      profile: @profile
    }, status: :ok
  end

  def respond_with_failure(resource)
    render json: {
      status: { code: 422, message: "Profile couldn't be created. #{resource.errors.full_messages.to_sentence}" }
    }, status: :unprocessable_entity
  end

  def respond_with_authentication_error
    render json: {
      status: { code: 401, message: "Unauthorized. Please sign in." }
    }, status: :unauthorized
  end
end
