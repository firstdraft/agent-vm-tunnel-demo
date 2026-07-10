class ApplicationController < ActionController::Base
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :prevent_response_storage

  private
    def prevent_response_storage
      response.headers["Cache-Control"] = "no-store"
    end
end
