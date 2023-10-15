# frozen_string_literal: true

# This module encapsulates filter-related functionality
module FiltersService

  # Class method Public (self) called 'matching_params' that takes a 'params' parameter
  # @return [Hash]
  def self.matching_params(params)

    #Local variable 'new_hash' is created to store a hash with initial value { photographer: true }
    new_hash = { photographer: true }

    # Iterating through key-value pairs in 'params' hash using 'each_pair' method
    params.each_pair { |k, v|
    #Condition to check if key-value meets certain criteria using 'check_param' method
    new_hash[k.to_sym] = v if check_param(k, v) }

    #Sets a key in the 'new_hash' hash to a value that is a regular expression
    new_hash[:name] = /.*#{params[:name]}.*/ unless !params.key?(:name) || params[:name] == ''

    #Sets a key 'specialization.exists' in the hash 'new_hash' with the value 'true'
    new_hash[:specialization.exists] = true

    #Returns the hash 'new_hash' with the modifications made
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
