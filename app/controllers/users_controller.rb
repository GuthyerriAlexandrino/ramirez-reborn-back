# frozen_string_literal: true

# Class controller user
class UsersController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  # SpecializationService module instance
  Specialization = SpecializationService.instance
  # FireService module instance
  FireService = FireStorageService.instance
  before_action :user_params, only: :update

  # GET /users
  # Search all users by filter
  def index
    return render UserView.wrong_pagination unless FiltersService.check_pagination(params[:page])

    search_filters => filters, location
    filter_all_users(filters)
    @users.any_of!(*location) unless location.empty?
    @users = @users.page(params[:page]) unless params[:page].nil?
    render json: @users
  end

  # GET user/1
  # Search users by id
  def user_data
    user = authorize_request
    return if user.nil?
    return render json: { error: 'User cookie and id dont match' }, status: :bad_request if user.id.to_s != params[:id]

    render json: user, status: :ok
  end

  # GET user/1/followers
  def followers
    photographer = get_photographer

    render json: photographer.followers, status: :ok
  rescue Mongoid::Errors::InvalidFind
    render json: { error: 'Invalid photographer' }, status: :bad_request
  rescue Mongoid::Errors::MongoidError => e
    render json: { error: e.to_s.split[1] }, status: :internal_server_error
  end

  # GET user/1/
  # Search photographers that the user is following
  def following
    photographer = self.photographer
    render json: photographer.following, status: :ok
  rescue Mongoid::Errors::InvalidFind
    render json: { error: 'Invalid photographer' }, status: :bad_request
  rescue Mongoid::Errors::MongoidError => e
    render json: { error: e.to_s.split[1] }, status: :internal_server_error
  end

  # PUT /users/profile_image
  # Update user photo
  def profile_image
    user = authorize_request
    return if user.nil?

    filename = retrieve_filename(user)
    upload_image(filename)
    if User.find(user.id).update(profile_img: filename)
      render json: filename, status: :ok
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  # PUT /users/1
  def update
    user = authorize_request
    return if user.nil?
    return render json: { error: 'Invalid user token' }, status: :unprocessable_entity if user.id.to_s != params[:id]

    process_update_request(user)
    if User.find(user.id).update(@user_params)
      render json: user, status: :ok
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.where(id: params[:id]).first
  end

  def photographer
    user = authorize_request
    return nil if user.nil?

    User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    @user_params = params.require(:user).permit(UserService.all_permited)
  end

  def search_filters
    [
      FiltersService.matching_params(request.GET).merge(
        FiltersService.price_params(min_price: request.GET[:minPrice], max_price: request.GET[:maxPrice])
      ),
      FiltersService.location_params(request.GET[:location])
    ]
  end

  def filter_all_users(filters)
    order = FiltersService.order_params(request.GET[:orderBy])
    @users = User.where(filters).only(UserService.search_view).order_by(order)
  end

  def retrieve_filename(user)
    "#{user.name}/profile#{Rack::Mime::MIME_TYPES.invert[params[:image].content_type]}"
  end

  def upload_image(filename)
    bucket = FireService.img_bucket
    bucket.create_file(params[:image].tempfile, filename)
  end

  def process_update_request(user)
    @user_params[:photographer] = true if user.photographer
    @user_params[:specialization].each do |s|
      return render UserView.invalid_specialization unless Specialization.specializations.include?(s)
    end
  end
end
