require "google/cloud/storage"

# Singleton firestore
class FireStorageService
  attr_reader :img_bucket
  def FireStorageService.instance
    @instance ||= FireStorageService.new
  end

  private
  def initialize
    @storage = Google::Cloud::Storage.new project_id: 'ramirez-2bb46', credentials: GOOGLE_APPLICATION_CREDENTIALS
    @img_bucket = @storage.bucket('ramirez-2bb46.appspot.com')
  end
end