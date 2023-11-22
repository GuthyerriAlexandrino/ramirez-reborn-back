# frozen_string_literal: true

# Class responsible for handling the user followers
class Following
  include Mongoid::Document
  field :user_id, type: BSON::ObjectId
  embedded_in :user
end
