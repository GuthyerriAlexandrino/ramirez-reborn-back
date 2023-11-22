# frozen_string_literal: true

# A Post object who represents the possible posts in the database
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :image, type: String
  field :price, type: Float
  embedded_in :user
  embeds_many :likes
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 1, maximum: 160 }
  validates :price, numericality: { greater_than: 0, allow_nil: true }
end
