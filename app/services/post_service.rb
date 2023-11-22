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
  def self.get_post(author_id, post_id)
    author = User.find(author_id)
    raise(UserService::InvalidUserException.new, 'Invalid post author') if author.nil?

    author.posts&.find(post_id)
  end
end
