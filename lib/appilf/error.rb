# see https://developers.flippa.com/?shell#bad-request-(400)
module Appilf


  class Error < StandardError; end


  # Errors returned by Flippa
  # Raised on error 400
  class BadRequest < Error; end

  # Raised on error 401
  class Unauthorized < Error; end

  # Raised on error 403
  class Forbidden < Error; end

  # Raised on error 404
  class NotFound < Error; end

  # Raised on error 500
  class InternalServerError < Error; end

  # Errors within the gem
  class NonExistentPage < Error; end

end