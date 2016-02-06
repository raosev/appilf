module Appilf

  class Client

    module Users
      USER_PATH = "/users"

      def retrieve_user(user_id = nil)
        user_id ||= 'identify'
        response = authenticated_api_get("#{USER_PATH}/#{user_id}")
        Appilf::Util.translate_from_response(response)
      end

    end

  end
end