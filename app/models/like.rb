# frozen_string_literal: true

# A Like object that represents the photographer's possible likes in the database
class Like
  include Mongoid::Document
  field :user_id, type: BSON::ObjectId
  embedded_in :post
  embedded_in :comment
  embedded_in :answer

  # Validations
  validates :user_id, presence: true
end
