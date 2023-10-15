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

end
