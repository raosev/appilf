module Appilf

  class Client

    module Alerts

      PATH = "/alerts"

      def list_alerts
        response = authenticated_api_get("#{authenticated_user_path}#{PATH}")
        Appilf::Util.translate_from_response(response)
      end

    end

  end

end