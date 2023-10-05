# frozen_string_literal: true
# Service reponsible for creating user views
module UserService
  # Permitted parameters for user creation/update.
  # @return [Hash<Symbol, Hash<Array>]
  def self.all_permited
    [:name, :email, :photographer, :password, :password_confirmation,
     :city, :state,
     :bio, :profile_img, { specialization: [], services_price: [] }]
  end

  # Fields to view when fetching a user.
  # @return [Hash<Symbol, Hash<Array>]
  def self.search_view
    %i[name email profile_img specialization services_price city state views bio]
  end

  # Custom exception for invalid users.
  class InvalidUserException < StandardError; end
end
