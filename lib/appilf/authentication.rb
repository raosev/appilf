module Appilf

  module Authentication
    AUTHENTICATION_URL = 'https://api.flippa.com/v3/oauth2/token'

    attr_accessor :token, :username, :password, :access_token, :token_type


    def authenticate
      auth_by_password if username && password
    end


    private

    def auth_by_password
      response = send_post_request(AUTHENTICATION_URL,{ grant_type: 'password',
                                                        username: username,
                                                        password: password
                                                        })
      self.access_token = response['access_token']
      self.token_type = response['token_type']
    end


  end
end