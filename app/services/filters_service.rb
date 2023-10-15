# frozen_string_literal: true

# This module encapsulates filter-related functionality
module FiltersService


  def self.matching_params(params)
    new_hash = { photographer: true }
    params.each_pair { |k, v| new_hash[k.to_sym] = v if check_param(k, v) }
    new_hash[:name] = /.*#{params[:name]}.*/ unless !params.key?(:name) || params[:name] == ''
    new_hash[:specialization.exists] = true
    new_hash
  end

  # Class method that checks whether a key-value pair meets specific conditions
  # @return [Boolean]
  def self.check_param(key, value)
    # Constant Symbols: Defines a symbol with the key name to facilitate comparison
    key = key.to_sym

    # Constant Symbols: Condition 1 - Checks if the key is included in the symbol array
    condition1 = %i[name specialization].include?(key)

    # Constant String: Condition 2 - Checks if the value is not an empty string
    condition2 = value != '' && !value.nil?

    # Class Method: Checks if both conditions are true
    condition1 && condition2
  end

  # Defines the "check_param" method as a private class method
  private_class_method :check_param
end
