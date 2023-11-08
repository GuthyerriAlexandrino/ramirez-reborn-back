# frozen_string_literal: true

# Module responsible for returning registration-related json views
module RegistrationView
  def self.invalid_email
    { json: { error: 'Invalid email' }, status: :bad_request }
  end

  def self.short_password
    { json: { error: 'Password too short' }, status: :bad_request }
  end

  def self.wrong_password
    { json: { error: 'Password differs from confirmation' }, status: :bad_request }
  end

  def self.invalid_specialization
    { json: { error: 'Specialization don\'t exists' }, status: :bad_request }
  end

end
