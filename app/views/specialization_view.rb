# frozen_string_literal: true


# Module responsible for returning specialization-related json views
module SpecializationView
  def self.invalid_specialization
    { json: { error: 'Specialization don\'t exists' }, status: :bad_request }
  end
end
