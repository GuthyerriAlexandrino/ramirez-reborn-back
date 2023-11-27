# frozen_string_literal: true

# This module encapsulates post-related functionality
module PostService
  # Method responsible for returning all posts of an user
  # @return [Array<Post>]
  # @param user_id [String]
  def self.user_posts(user_id)
    user = User.find(_id: user_id)
    user.posts
  end

  # Method responsible for returning all allowed parameters of a post
  # @return [Hash]
  # @param title [String]
  # @param price [Float]
  # @param uri [String]
  def self.post_params(title, price, uri)
    post = { title:, image: uri }
    post[:price] = price.to_f unless price.nil?
    post
  end

  # Method responsible for parsing filename
  # @return [String]
  # @param user_name [String]
  # @param content_type [String]
  def self.parse_filename(user_name, content_type)
    ext = Rack::Mime::MIME_TYPES.invert[content_type]
    "#{user_name}/#{SecureRandom.uuid}#{ext}"
  end

  # Method responsible for getting an user post
  # @return [Post]
  # @param author_id [String]
  # @param post_id [String]
  def self.get_post(post_id)
    user = User.where('posts._id' => post_id).first
    post_oid = BSON::ObjectId.from_string(post_id)
    user.posts.detect { |p| p._id == post_oid }
  end
end
