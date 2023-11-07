# frozen_string_literal: true

module LikeService

  # Method responsible for obtaining the like given by a user in a comment or post
  # @return [Object]
  # @param user_id [Integer]
  # @param likeable [Object]
  def self.get_like(user_id, likeable)
    return likeable.likes&.find(user_id) if likeable.instance_of?(Post)

    likeable.likes&.find(user_id) if likeable.instance_of?(Comment)
  end

end
