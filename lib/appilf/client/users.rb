module Appilf

  class Client

    module Users
      PATH = "#{APIActions::BASE_API_URL}/users"

      def retrieve_user(user_id = nil)
        user_id ||= 'identify'
        response = authenticated_api_get("#{PATH}/#{user_id}")
        Appilf::Util.translate_from_response(response)
      end

    end

  end
end