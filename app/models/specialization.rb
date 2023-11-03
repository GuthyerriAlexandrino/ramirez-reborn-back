# frozen_string_literal: true

# A Specialization object who represents the possible photographer specializations in the database
class Specialization
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name, type: String

  # Validations
  validates :name, uniqueness: true
end
