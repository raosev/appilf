module Appilf

  module APIActions
    BASE_API_URL = 'https://api.flippa.com/v3'

    def api_post(path, payload, headers = {})
      # RestClient::Request.execute(method: :delete, url: 'http://example.com/resource',
      #                             payload: 'foo', headers: {myheader: 'bar'})
      response = RestClient::Request.execute(method: :post, url: endpoint_url(path),
                                             payload: payload, headers: headers)
      JSON.parse(response)
    rescue RestClient::RequestFailed => e
      handle_from_response(e)
    end

    def api_get(path, headers = {})
      # RestClient::Request.execute(method: :delete, url: 'http://example.com/resource',
      #                             payload: 'foo', headers: {myheader: 'bar'})
      response = RestClient::Request.execute(method: :get, url: endpoint_url(path), headers: headers)
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

    def endpoint_url(request_path)
      "#{BASE_API_URL}#{request_path}"
    end


  end

end