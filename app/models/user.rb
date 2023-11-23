# frozen_string_literal: true

# A User object who implements its scope, validations and relations
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  include ActiveModel::Validations

  has_secure_password
  before_save { email.downcase! }

  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :password_digest, type: String
  field :specialization, type: Array
  field :city, type: String
  field :state, type: String
  field :services_price, type: Array, default: [0.0, 0.0]
  field :views, type: Integer, default: 0
  field :bio, type: String, default: nil
  field :profile_img, type: String, default: ''
  field :photographer, type: Boolean
  index({ email: 1 }, { unique: true })

  # Scopes
  scope :followers, -> { Follower.where(user_id: :id) }
  scope :following, -> { Following.where(user_id: :id) }

  # Validations
  validates :name, length: { minimum: 1, maximum: 160 }
  validates :services_price, length: { minimum: 2, maximum: 2 }, allow_nil: true
  validates :city, length: { minimum: 1, maximum: 70 }, allow_nil: true
  validates :state, length: { minimum: 2, maximum: 2 }, allow_nil: true
  validates :bio, length: { minimum: 20, maximum: 1000 }, allow_nil: true
  validates :email, uniqueness: true

  # Embeddings
  embeds_many :posts
  embeds_many :followers
  embeds_many :following

  # Methods

  # Makes a user follow another
  # @param other [User]
  # @return [Nil]
  def follow(other)
    following.create!(other)
    other.followers.create!(id)
  end

  # Makes a user unfollow another
  # @param other [User]
  # @return [Nil]
  def unfollow(other)
    following.destroy!(other)
    other.followers.destroy!(id)
  end
end
