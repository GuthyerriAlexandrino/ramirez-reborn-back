# Class for handling JSON Web Tokens (JWTs)
class JsonWebToken
  # Constant storing the secret key for encoding and decoding JWTs
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # Method to encode a payload into a JWT
  def self.encode(payload, exp = 24.hours.from_now)
    # Set the expiration time in the payload
    payload[:exp] = exp.to_i
    # Encode the payload using the secret key
    JWT.encode(payload, SECRET_KEY)
  end

  # Method to decode a JWT and retrieve the payload
  def self.decode(token)
    # Decode the JWT using the secret key and retrieve the payload
    decoded = JWT.decode(token, SECRET_KEY)[0]
    # Return the decoded payload as a Hash with indifferent access
    HashWithIndifferentAccess.new(decoded)
  end
end
