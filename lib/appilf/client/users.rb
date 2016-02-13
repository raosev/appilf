module Appilf

  class Client

    module Users

      def retrieve_user(user_id = nil)
        response = authenticated_api_get(users_path(user_id))
        Appilf::Util.translate_from_response(response)
      end

      def users_path(user_id = nil)
        user_id ||= 'identify'
        "#{APIActions::BASE_API_URL}/users/#{user_id}"
      end

    end

  end
end