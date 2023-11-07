# frozen_string_literal: true

module LikeService

  def self.get_like(user_id, likeable)
    return likeable.likes&.find(user_id) if likeable.instance_of?(Post)

    likeable.likes&.find(user_id) if likeable.instance_of?(Comment)
  end

end
