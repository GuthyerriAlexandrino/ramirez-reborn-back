# frozen_string_literal: true

# Service reponse to vision user
module UserService
  def UserService.all_permited
    [:name, :email, :photographer, :password, :password_confirmation,
     :city, :state,
     :bio, :profile_img, :specialization => [], :services_price => []]
  end

  def UserService.search_view
    [:name, :email, :profile_img, :specialization, :services_price, :city, :state, :views, :bio]
  end

  class InvalidUserException < StandardError; end
end