require "google/cloud/storage"

# Singleton firestore
class FireStorageService
  attr_reader :img_bucket
  def FireStorageService.instance
    @instance ||= FireStorageService.new
  end