# frozen_string_literal: true

module UserView
  # @param page [Integer, String]
  # @param func [Proc]
  # @return [Json]
  def self.wrong_pagination
    { json: { error: 'Page field must be integer' }, status: :bad_request }
  end

  def self.invalid_specialization
    { json: { error: 'Invalid specialization' }, status: :unprocessable_entity }
  end
end
