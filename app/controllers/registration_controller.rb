class RegistrationController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  HOURS = 2.hours
  SPECIALIZATIONS = SpecializationService.instance.specializations

  def login
    user_params = login_params
    begin
      @user = User.find_by(email: user_params[:email].downcase)
    rescue Exception
      return render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    if @user.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: @user.id, exp: HOURS.from_now)
      time = Time.now + HOURS.to_i
      render json: { token:, exp: time.strftime('%Y-%m-%dT%H:%M'),
                     user: @user._id }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def register
    user_params = register_params
    return render json: { error: 'Invalid email' }, status: :bad_request unless user_params[:email] =~ VALID_EMAIL_REGEX
    return render json: { error: 'Password too short' }, status: :bad_request unless user_params[:password].length >= 8
    return render json: { error: 'Password differs from confirmation' }, status: :bad_request unless user_params[:password] == user_params[:password_confirmation]

    # return render json: { error: 'Specialization don\'t exists'}, status: :bad_request unless SPECIALIZATIONS.include?(user_params[:specialization])

    begin
      u = User.create!(user_params.permit(user_params.keys).to_h)
      u.password = nil
      render json: u, status: :ok
    rescue Mongoid::Errors::Validations => e
      render json: { error: e.to_s.split[1] }, status: :conflict
    rescue Mongoid::Errors => e
      render json: { error: e.to_s.split[1] }, status: :conflict
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password).tap { |u| u.require([:email, :password]) }
  end

  def register_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :city, :state, :photographer).tap do |u|
      u.require([:name, :email, :password, :password_confirmation, :photographer])
    end
  end
end
