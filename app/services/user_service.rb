# frozen_string_literal: true

# Service reponse to vision user
module UserService
  # Permitted parameters for user creation/update.
  def self.all_permited
    [:name, :email, :photographer, :password, :password_confirmation,
     :city, :state,
     :bio, :profile_img, { specialization: [], services_price: [] }]
  end

  # Fields to view when fetching a user.
  def self.search_view
    %i[name email profile_img specialization services_price city state views bio]
  end

  # Custom exception for invalid users.
  class InvalidUserException < StandardError; end
end
