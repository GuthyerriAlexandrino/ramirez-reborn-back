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
  validates :services_price, length: { minimum: 2, maximum: 2 }, presence: false
  validates :city, length: { minimum: 1, maximum: 70 }, presence: false
  validates :state, length: { minimum: 2, maximum: 2 }, presence: false
  validates :bio, length: { minimum: 20, maximum: 1000 }, presence: false
  validates :email, uniqueness: true
end
