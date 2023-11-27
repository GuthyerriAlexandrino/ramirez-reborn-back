# frozen_string_literal: true

# Class responsible for all comment-related
class CommentsController < ApplicationController
  Mongoid.raise_not_found_error = false
  before_action :set_comment, only: :destroy
  before_action :set_post, only: :create

  # GET /comments/{post_id}
  def index
    @comments = Comment.where({ post_id: params[:id] })
    render json: @comments
  end

  # POST /comments
  def create
    user = authorize_request
    return if user.nil?

    begin
      raise(*create_object_error) if @post.nil?

      comment = @post.comments.create!({ user_id: user.id, content: comment_params[:content] })
      render json: comment, status: :created
    rescue Mongoid::Errors => e
      render json: { error: e }, status: :bad_request
    end
  end

  # POST /comments/1
  def like
    user = authorize_request
    return if user.nil?

    begin
      raise self::InvalidPostException.new, 'This author is not the owner of the specified post' if @post.nil?

      render LikeService.like(user.id, @comment)
    rescue StandardError => e
      render json: { error: e }, status: :bad_request
    end
  end

  # DELETE /comments/1
  def destroy
    user = authorize_request
    return if user.nil?

    unless user.id == @comment.user_id
      return render json: { error: 'Specified user is not the owner of the comment' }, status: :bad_request
    end

    @comment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    set_post
    @comment = CommentService.get_comment(request[:id], @post)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = PostService.get_post(comment_params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_id, :content, :post_id, :id, :post)
  end

  def comment_search_params
    params.require(:comment).permit(:post).tap { |c| c.require(%i[post]) }
  end

  def create_object_error
    [Mongoid::Errors::DocumentNotFound.new(Post, comment_params[:post_id]), 'Post not found']
  end
end
