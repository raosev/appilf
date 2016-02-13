module Appilf

  class Client

    module Alerts

      def list_alerts
        response = authenticated_api_get(alerts_path)
        # workaround since alert's response does not come within the data field
        Appilf::Util.translate_from_response({'data' => response})
      end

      def alerts_path
        "#{authenticated_user_path}/alerts"
      end

    end

  end

end