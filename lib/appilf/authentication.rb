module Appilf

  module Authentication
    AUTHENTICATION_PATH = "/oauth2/token"

    attr_accessor :token, :username,
                  :password,
                  :access_token,
                  :token_type,
                  :user


    def authenticate
      auth_by_password if username && password
    end

    def authentication_headers
      { Authorization: self.access_token }
    end

    def authenticated_user_path
      "#{Appilf::Client::Users::PATH}/#{user.id}"
    end

    private

    def auth_by_password
      response = api_post(AUTHENTICATION_PATH,{ grant_type: 'password',
                                                        username: username,
                                                        password: password
                                                        })
      self.access_token = response['access_token']
      self.token_type = response['token_type']
    end


  end
end