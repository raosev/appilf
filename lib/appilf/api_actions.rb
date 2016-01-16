module Appilf

  module APIActions

    def send_post_request(url, payload)
      # RestClient::Request.execute(method: :delete, url: 'http://example.com/resource',
      #                             payload: 'foo', headers: {myheader: 'bar'})
      response = RestClient::Request.execute(method: :post, url: url, payload: payload)
      JSON.parse(response)
    rescue RestClient::RequestFailed => e
      handle_from_response(e)
    end


    def handle_from_response(response_error)
      message = JSON.parse(response_error.response)['error']
      case response_error.http_code
        when 400
          raise BadRequest.new(message)
        when 401
          raise Unauthorized.new(message)
        when 403
          raise Forbidden.new(message)
        when 404
          raise NotFound.new(message)
        when 500
          raise InternalServerError.new(message)
        else
          raise response_error
      end
    end

  end

end