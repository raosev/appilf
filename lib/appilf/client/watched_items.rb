module Appilf

  class Client

    module WatchedItems

      def create_watched_item(item_type, item_id)
        response = authenticated_api_post(watched_items_path, {
                                                                                 item_type: item_type,
                                                                                 item_id: item_id
                                                                             })
        Appilf::Util.translate_from_response(response)
      end

      def delete_watched_item(item_type, item_id)
        authenticated_api_delete(watched_items_path, {
                                                                        item_type: item_type,
                                                                        item_id: item_id
                                                                    })
      end

      def watched_items_path
        "#{authenticated_user_path}/watched-items"
      end


    end

  end

end