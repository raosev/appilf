module Appilf

  module APIActions
    BASE_API_URL = 'https://api.flippa.com/v3'

    def api_post(path, payload, headers = {})
      response = RestClient::Request.execute(method: :post, url: path,
                                             payload: payload, headers: headers)
      JSON.parse(response)
    rescue RestClient::RequestFailed => e
      handle_from_response(e)
    end

    def api_delete(path, payload, headers = {})
      RestClient::Request.execute(method: :delete, url: path,
                                  payload: payload, headers: headers)
      :success
    rescue RestClient::RequestFailed => e
      handle_from_response(e)
    end

    def api_get(path, headers = {})
      response = RestClient::Request.execute(method: :get, url: path, headers: headers)
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