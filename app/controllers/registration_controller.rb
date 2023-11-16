# frozen_string_literal: true

# Class responsible for login and register features
class RegistrationController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  before_action :register_params, only: :register
  before_action :login_params, only: :login
  # Defines what is a valid email
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # Login token expiration time
  HOURS = 2.hours
  # Photographer specializations available by system
  SPECIALIZATIONS = SpecializationService.instance.specializations
  # Wraps the view used by this controller
  VIEW = RegistrationView
  # Minimum length of password
  PASS_LENGTH = 8

  # Method responsible for login of users, returning the JWT token, expiration date and user id if login is succesfull
  # or unauthorized error if unsuccessfull.
  # @return [Json]
  def login
    @user = User.find_by(email: @login_params[:email].downcase)

    if @user&.authenticate(@login_params[:password])
      time = Time.zone.now + HOURS.to_i
      render json: { token: JsonWebToken.encode(user_id: @user.id, exp: HOURS.from_now),
                     exp: time.strftime('%Y-%m-%dT%H:%M'), user: @user._id }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # Method responsible for login of users, returning the JWT token, expiration date and user id if login is succesfull
  # or unauthorized error if unsuccessfull.
  # @return [Json]
  def register
    register_check = check_registration_params
    return render register_check unless register_check

    begin
      u = User.create!(@register_params.permit(@register_params.keys).to_h)
      u.password = nil
      render json: u, status: :ok
    rescue Mongoid::Errors::Validations => e
      render json: { error: e.to_s.split[1] }, status: :conflict
    end
  end

  private

  def check_registration_params
    return VIEW.invalid_email unless @register_params[:email] =~ VALID_EMAIL_REGEX
    return VIEW.short_password unless @register_params[:password].length >= PASS_LENGTH
    return VIEW.wrong_password unless @register_params[:password] == @register_params[:password_confirmation]
    return VIEW.invalid_specialization unless SPECIALIZATIONS.include?(@register_params[:specialization])

    true
  end

  def login_params
    @login_params = params.require(:user).permit(:email, :password).tap { |u| u.require(%i[email password]) }
  end

  def register_params
    @register_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :city, :state,
                                                    :photographer).tap do |u|
      u.require(%i[name email password password_confirmation photographer])
    end
  end
end
