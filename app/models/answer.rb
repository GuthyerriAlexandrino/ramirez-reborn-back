# frozen_string_literal: true

# Answer-related database features
class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_id, type: BSON::ObjectId
  field :answer_ref_id, type: BSON::ObjectId, default: nil
  field :content, type: String

  # Validations
  validates :content, length: { minimum: 1, maximum: 500 }

  embedded_in :comment
  embeds_many :likes
end
