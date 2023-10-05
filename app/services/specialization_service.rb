# Singleton class
class SpecializationService
  # Constant: List of specializations
  attr_reader :specializations
  
  # Method to get the singleton instance of SpecializationService
  # @return [SpecializationService]
  def SpecializationService.instance
    @instance ||= SpecializationService.new
  end

  