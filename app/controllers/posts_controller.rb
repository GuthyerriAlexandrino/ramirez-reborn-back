# frozen_string_literal: true

# Class responsible for all posts-specific needs and rules
class PostsController < ApplicationController
  before_action :set_post, only: :show
  before_action :set_posts, only: :index
  before_action :authorize_request, only: %i[index]

  # GET /posts/1
  def index
    render json: @post
  end

  # GET /post/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    user = authorize_request
    return if invalid_user_or_missing_image?(user)

    return render_unauthorized unless user.photographer

    upload_and_create_post(user)
  end

  # DELETE /posts/1
  def destroy
    user = authorize_request
    return if user.nil?

    delete_user_post(user)
  end

  private

  def invalid_user_or_missing_image?(user)
    user.nil? || post_params[:image].nil?
  end

  def render_unauthorized
    render json: { error: 'User is not a photographer' }
  end

  def upload_and_create_post(user)
    filename = upload_file(user)
    return unless filename

    post_hash = PostService.post_params(post_params[:title], post_params[:price], filename)
    create_post_and_handle_errors(user, post_hash)
  end

  def upload_file(user)
    return unless user && post_params[:image]

    bucket = FireStorageService.instance.img_bucket
    file_uploaded = post_params[:image].tempfile
    filename = PostService.parse_filename(user.name, post_params[:image].content_type)
    res = bucket.create_file(file_uploaded, filename)
    res ? filename : nil
  end

  def create_post_and_handle_errors(user, post_hash)
    user.posts.create!(post_hash)
    render json: post_hash, status: :created
  rescue Mongoid::Errors => e
    handle_post_creation_error(user, post_hash, e)
  end

  def handle_post_creation_error(user, post_hash, error)
    if user && post_hash[:filename]
      bucket = FireStorageService.instance.img_bucket
      bucket.file(post_hash[:filename]).delete
    end
    render json: { error: error.message, post: post_hash }, status: :unprocessable_entity
  end

  def delete_user_post(user)
    post = find_user_post(user)
    return render_post_not_found unless post

    delete_post_image(post)
    user.posts.delete(post)
    render json: post, status: :ok
  rescue Mongoid::Errors => e
    render json: { error: e }, status: :unprocessable_entity
  end

  def find_user_post(user)
    user.posts.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def delete_post_image(post)
    bucket = FireStorageService.instance.img_bucket
    bucket.file(post.image).delete
  end

  def render_post_not_found
    render json: { error: 'Post not found' }, status: :not_found
  end

  def set_posts
    @post = PostService.user_posts(params[:id])
  end

  def set_post
    @post = User.find(params[:u_id]).posts.find(params[:p_id])
  end

  def post_params
    params.permit(:image, :price, :title).tap { |p| p.require(:image) }
  end
end
