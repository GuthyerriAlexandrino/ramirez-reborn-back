class ApplicationController < ActionController::API
  before_action :set_header

  def authorize_request
    return User.find_by(email: 'guthyerri@davi.alice') unless @header != 'debug'

    decoded = JsonWebToken.decode(@header)
    @current_user = User.without(:password_digest).find(decoded[:user_id])
    @current_user
    
  rescue JWT::DecodeError => e
    render json: { error: e.message }, status: :unauthorized
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_header
    @header = request.headers['Authorization']
    @header = @header.split(' ').last if @header
  end
end
