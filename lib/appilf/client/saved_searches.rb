module Appilf

  class Client

    module SavedSearches

      PATH = "#{APIActions::BASE_API_URL}/saved-searches"

      def list_saved_searches
        response = authenticated_api_get("#{authenticated_user_path}#{PATH}")
        Appilf::Util.translate_from_response(response)
      end

      def delete_saved_search(saved_search_id)
        authenticated_api_delete("#{PATH}/#{saved_search_id}", {})
      end

    end

  end

end