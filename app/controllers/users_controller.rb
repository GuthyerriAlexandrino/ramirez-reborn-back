# frozen_string_literal: true

# Class controller user
class UsersController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  before_action :authorize_request, except: %i[create update show]
  before_action :set_user, only: :show

  # GET /users
  # Search all users by filter
  def index
    unless FiltersService.check_pagination(params[:page])
      return render json: { error: 'Page field must be integer' },
                    status: :bad_request
    end
    filters = FiltersService.matching_params(request.GET)
    location = FiltersService.location_params(request.GET[:location])
    order = FiltersService.order_params(request.GET[:orderBy])
    price = FiltersService.price_params(min_price: request.GET[:minPrice], max_price: request.GET[:maxPrice])
    @users = User.where(filters.merge(price)).only(UserService.search_view).order_by(order)
    @users = @users.any_of(*location) unless location.empty?
    render json: @users.page(params[:page])
  end

  # GET user/1
  # Search users by id
  def user_data
    user = authorize_request
    return if user.nil?
    return render json: { error: 'User cookie and id dont match' }, status: :bad_request if user.id.to_s != params[:id]

    render json: user, status: :ok
  end

  # GET user/1/
  # Search photographers that the user is following
  def following
    photographer = get_photographer
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

    bucket = FireStorageService.instance.img_bucket
    file = params[:image]
    filename = "#{user.name}/profile#{Rack::Mime::MIME_TYPES.invert[file.content_type]}"
    bucket.create_file(file.tempfile, filename)
    update_user = User.find(user.id)
    if update_user.update(profile_img: filename)
      render json: filename, status: :ok
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end


  # DELETE /users/1
  # delete user by Id
  def destroy
    @user.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.where(id: params[:id]).first
  end

  def get_photographer
    user = authorize_request
    return nil if user.nil?

    User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(UserService.all_permited)
  end


  # PUT /users/1
  #  update user datas
  def update
    user = authorize_request
    return if user.nil?
    return render json: { error: 'Invalid user token' }, status: :unprocessable_entity if user.id.to_s != params[:id]

    u_params = user_params
    u_params[:photographer] = true if user.photographer = true
    u_params[:specialization].each do |s|
      unless SpecializationService.instance.specializations.include?(s)
        return render json: { error: 'Invalid specialization' } , status: :unprocessable_entity
      end
    end
    update_user = User.find(user.id)

    if update_user.update(u_params)
      render json: user, status: :ok
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end
end
