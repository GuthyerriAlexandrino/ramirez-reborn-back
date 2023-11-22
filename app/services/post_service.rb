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

    
  end