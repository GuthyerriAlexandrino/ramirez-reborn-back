# frozen_string_literal: true

module FiltersService

  # Class method that checks whether a key-value pair meets specific conditions
  # @return [Boolean]
  def self.check_param(key, value)
    key = key.to_sym
    condition1 = %i[name specialization].include?(key)
    condition2 = value != "" && !value.nil?

    condition1 && condition2
  end

  # Defines the "check_param" method as a private class method
  private_class_method :check_param

end
