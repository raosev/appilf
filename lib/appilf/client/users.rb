module Appilf

  class Client

    module Users
      USER_PATH = "/users"

      def identify
        response = authenticated_api_get("#{USER_PATH}/identify")
        Appilf::Util.translate_from_response(response)
      end

    end

  end
end