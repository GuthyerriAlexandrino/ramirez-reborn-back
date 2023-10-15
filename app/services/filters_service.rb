# frozen_string_literal: true

module FiltersService

  def self.check_param(key, value)
    key = key.to_sym
    condition1 = %i[name specialization].include?(key)
    condition2 = value != "" && !value.nil?

    condition1 && condition2
  end

  private_class_method :check_param

end
