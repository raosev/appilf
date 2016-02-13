module Appilf

  class Client

    module SavedSearches

      def list_saved_searches
        response = authenticated_api_get(saved_searches_path)
        Appilf::Util.translate_from_response(response)
      end

      def delete_saved_search(saved_search_id)
        authenticated_api_delete(saved_searches_path(saved_search_id), {})
      end

      def saved_searches_path(saved_search_id = nil)
        return "#{authenticated_user_path}/saved-searches" if saved_search_id.nil?
        "#{Appilf::APIActions::BASE_API_URL}/saved-searches"
      end

    end

  end

end