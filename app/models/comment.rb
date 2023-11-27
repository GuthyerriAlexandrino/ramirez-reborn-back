# frozen_string_literal: true

# Class responsible for handling
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: BSON::ObjectId
  field :content, type: String

  # Validations
  validates :content, length: { minimum: 1, maximum: 500 }

  # Embeddings
  belongs_to :post
  embeds_many :likes
  embeds_many :answers
end
