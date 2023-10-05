# frozen_string_literal: true

# Class for handling JSON Web Tokens (JWTs)
class JsonWebToken
  # Constant storing the secret key for encoding and decoding JWTs
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # Method to encode a payload into a JWT
  # @param payload [Hash]
  # @param exp [Integer]
  # @return [String]
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Method to decode a JWT and retrieve the payload
  # @param token [String]
  # @return [String]
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    ActiveRecord::HashWithIndifferentAccess.new(decoded)
  end
end
