# frozen_string_literal: true

require 'rails_helper'

describe FiltersService do
  context 'Matching Params' do
    it 'Returns photographer with no other filters' do
      filter = described_class.matching_params({})
      expect(filter).to eq({ photographer: true, :specialization.exists => true })
    end

    it 'returns a hash with :name key when name is not empty' do
      params = { name: 'John Doe' }
      result = described_class.matching_params(params)
      expect(result.key?(:name)).to be(true)
    end

    it 'returns a hash without :name key when name is empty' do
      params = { name: '' }
      result = described_class.matching_params(params)
      expect(result.key?(:name)).to be(false)
    end

    it 'returns a hash without :name key when :name is not present in params' do
      params = { specialization: 'Photography' }
      result = described_class.matching_params(params)
      expect(result.key?(:name)).to be(false)
    end

    it 'returns a hash with :photographer.exists key' do
      params = { photographer: true }
      result = described_class.matching_params(params)
      expect(result).to include(photographer: true)
    end

    it 'returns a hash without :specialization.exists key when specialization is empty' do
      params = { specialization: '' }
      result = described_class.matching_params(params)
      expect(result.key?(:'specialization.exists')).to be(false)
    end
  end

  context 'Location Params' do
    it 'returns a list with city criteria when location is a city' do
      location = 'New York'
      result = described_class.location_params(location)
      expect(result).to include({ city: 'New York' })
    end

    it 'returns a list with state criteria when location is a state' do
      location = 'California'
      result = described_class.location_params(location)
      expect(result).to include({ state: 'California' })
    end

    it 'returns an empty list when location is nil' do
      location = nil
      result = described_class.location_params(location)
      expect(result).to eq([])
    end

    it 'returns an empty list when location is an empty string' do
      location = ''
      result = described_class.location_params(location)
      expect(result).to eq([])
    end

    it 'returns a list with both city and state criteria when location is a city and state' do
      location = 'Los Angeles, California'
      result = described_class.location_params(location)
      expect(result).to include({ city: 'Los Angeles, California' }, { state: 'Los Angeles, California' })
    end
  end

  context 'Order Params' do
    it 'returns an empty hash when order_by is an empty string' do
      order_by = ''
      result = described_class.order_params(order_by)
      expect(result).to eq({})
    end

    it 'returns an empty hash when order_by is not in the allowed values' do
      order_by = 'rating'
      result = described_class.order_params(order_by)
      expect(result).to eq({})
    end

    it 'returns a hash with likes field in descending order' do
      order_by = 'likes'
      result = described_class.order_params(order_by)
      expect(result).to eq({ likes: :desc })
    end

    it 'returns a hash with views field in descending order' do
      order_by = 'views'
      result = described_class.order_params(order_by)
      expect(result).to eq({ views: :desc })
    end

    it 'returns a hash with price field in descending order' do
      order_by = 'price'
      result = described_class.order_params(order_by)
      expect(result).to eq({ price: :desc })
    end

    it 'returns an empty hash when order_by is nil' do
      order_by = nil
      result = described_class.order_params(order_by)
      expect(result).to eq({})
    end
  end

  context "Check Pagination" do
    it 'returns true when page is nil' do
      page = nil
      result = FiltersService.check_pagination(page)
      expect(result).to be(true)
    end

    it 'returns true when page is an integer' do
      page = 1
      result = FiltersService.check_pagination(page)
      expect(result).to be(true)
    end


  end

end
