# frozen_string_literal: true

require 'user_service'

describe UserService do
  context 'When all parameters are allowed' do
    it 'Return a specific list ' do
      result = UserService.all_permited
      expect(result).to be_an(Array)
      expect(result).to eq([:name, :email, :photographer, :password, :password_confirmation,
                            :city, :state,
                            :bio, :profile_img, :specialization => [], :services_price => []])
    end
  end

  context 'When only search parameters are allowed' do
    it 'Return a specific list' do
      result = UserService.search_view
      expect(result).to be_an(Array)
      expect(result).to eq([:name, :email, :profile_img, :specialization, :services_price, :city, :state, :views, :bio])
    end
  end
end
