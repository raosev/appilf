module Appilf

  class Client

    module WatchedItems

      PATH = "#{APIActions::BASE_API_URL}/watched-items"

      def create_watched_item(item_type, item_id)
        response = authenticated_api_post("#{authenticated_user_path}#{PATH}", {
                                                                                 item_type: item_type,
                                                                                 item_id: item_id
                                                                             })
        Appilf::Util.translate_from_response(response)
      end

      def delete_watched_item(item_type, item_id)
        authenticated_api_delete("#{authenticated_user_path}#{PATH}", {
                                                                        item_type: item_type,
                                                                        item_id: item_id
                                                                    })
      end

    end

  end

end