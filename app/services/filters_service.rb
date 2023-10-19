# frozen_string_literal: true

# This module encapsulates filter-related functionality
module FiltersService
  # Method responsible for returning photographer search parameters that are valid
  # @return [Hash]
  # @param params [Hash]
  def self.matching_params(params)
    new_hash = { photographer: true }
    params.each_pair do |k, v|
      new_hash[k.to_sym] = v if check_param(k, v)
    end
    new_hash[:name] = /.*#{params[:name]}.*/ unless !params.key?(:name) || params[:name] == ''
    new_hash[:specialization.exists] = true
    new_hash
  end

  # Method responsible for creating photographer location criteria based on the cities or states provided
  # @return [Hash]
  # @param location [String]
  def self.location_params(location)
    locate = []
    locate = [{ city: location }, { state: location }] unless location.nil? || location == ''
    locate
  end

  def self.order_params(order_by)
    order = {}
    order = { order_by.to_sym => :desc } if order_by != '' && %w[likes views price].include?(order_by)
    order
  end

  # Method responsible for checking whether parameters contain valid values
  # @return [Boolean]
  # @param key [String]
  # @param value [String, Integer]
  def self.check_param(key, value)
    key = key.to_sym
    condition1 = %i[name specialization].include?(key)
    condition2 = value != '' && !value.nil?
    condition1 && condition2
  end

  private_class_method :check_param
end
