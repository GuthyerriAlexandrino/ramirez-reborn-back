require 'rails_helper'

describe FiltersService do
  context 'Matching Params' do
    it 'Returns photographer with no other filters' do
      filter = FiltersService.matching_params({})
      expect(filter).to eq({ photographer: true, :specialization.exists => true })
    end

    it 'returns a hash with :name key when name is not empty' do
      params = { name: 'John Doe' }
      result = FiltersService.matching_params(params)
      expect(result.key?(:name)).to be(true)
    end

    it 'returns a hash without :name key when name is empty' do
      params = { name: '' }
      result = FiltersService.matching_params(params)
      expect(result.key?(:name)).to be(false)
    end

    it 'returns a hash without :name key when :name is not present in params' do
      params = { specialization: 'Photography' }
      result = FiltersService.matching_params(params)
      expect(result.key?(:name)).to be(false)
    end

    it 'returns a hash with :photographer.exists key' do
      params = { photographer: true}
      result = FiltersService.matching_params(params)
      expect(result).to include(:"photographer" => true)
    end

    it 'returns a hash without :specialization.exists key when specialization is empty' do
      params = { specialization: '' }
      result = FiltersService.matching_params(params)
      expect(result.key?(:"specialization.exists")).to be(false)
    end

  end

  context "Location Params" do
    it 'returns a list with city criteria when location is a city' do
      location = 'New York'
      result = FiltersService.location_params(location)
      expect(result).to include({ city: 'New York' })
    end

    it 'returns a list with state criteria when location is a state' do
      location = 'California'
      result = FiltersService.location_params(location)
      expect(result).to include({ state: 'California' })
    end

    it 'returns an empty list when location is nil' do
      location = nil
      result = FiltersService.location_params(location)
      expect(result).to eq([])
    end

    it 'returns an empty list when location is an empty string' do
      location = ''
      result = FiltersService.location_params(location)
      expect(result).to eq([])
    end

    it 'returns a list with both city and state criteria when location is a city and state' do
      location = 'Los Angeles, California'
      result = FiltersService.location_params(location)
      expect(result).to include({ city: 'Los Angeles, California' }, { state: 'Los Angeles, California' })
    end

  end


end
