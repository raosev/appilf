module Appilf

  class Client

    module Alerts

      PATH = "/alerts"

      def list_alerts
        response = authenticated_api_get("#{authenticated_user_path}#{PATH}")
        # workaround since alert's response does not come within the data field
        Appilf::Util.translate_from_response({'data' => response})
      end

    end

  end

end