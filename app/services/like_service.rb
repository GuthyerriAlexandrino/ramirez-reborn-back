# frozen_string_literal: true

# This module encapsulates like-related functionalities
module LikeService
  # Method responsible for obtaining the like given by a user in a comment or post
  # @return [Object]
  # @param user_id [Integer]
  # @param likeable [Object]
  def self.get_like(user_id, likeable)
    likeable.likes&.find(user_id)
  end

  # Method responsible for allowing a user to add or remove a like
  # @return [Hash]
  # @param user_id [Integer]
  # @param likeable [Object]
  def self.like(user_id, likeable)
    like = get_like(user_id, likeable)
    if like.nil?
      likeable.likes.create!(user_id: user.id)
      return { json: 'Object created', status: :ok }
    end
    like.destroy
    { json: 'Object destroyed', status: :ok }
  end
end
