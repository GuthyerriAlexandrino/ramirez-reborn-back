# Require the Google Cloud Storage library
require "google/cloud/storage"

# Singleton class for Google Cloud Storage
class FireStorageService
  # Constant: Image bucket attribute
  attr_reader :img_bucket

  # Method to get the singleton instance of FireStorageService
  def FireStorageService.instance
    # Create a single instance of FireStorageService if it doesn't exist
    @instance ||= FireStorageService.new
  end

  private

  # Constructor: initializes a new instance and connects to Google Cloud Storage
  def initialize
    # Initialize the Google Cloud Storage client with project ID and credentials
    @storage = Google::Cloud::Storage.new(project_id: 'ramirez-2bb46', credentials: GOOGLE_APPLICATION_CREDENTIALS)

    # Set the img_bucket attribute to reference a specific Google Cloud Storage bucket
    @img_bucket = @storage.bucket('ramirez-2bb46.appspot.com')
  end
end
