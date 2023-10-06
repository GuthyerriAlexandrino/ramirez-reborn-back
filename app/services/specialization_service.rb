# Singleton class
class SpecializationService
  # Constant: List of specializations
  attr_reader :specializations
  
  # Method to get the singleton instance of SpecializationService
  # @return [SpecializationService]
  def SpecializationService.instance
    @instance ||= SpecializationService.new
  end

  private
  # Constructor: initializes a new instance and builds specializations
  def initialize
    @specializations = build_specializations()
  end

  # Method to build the list of specializations
  # @return [Hash]
  def build_specializations()
    sps = Set.new()
    sp = Specialization.all()
    sp.each { |s| sps << s[:name] }
    sps
  end
end
