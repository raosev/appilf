module Appilf

  class Client

    module DomainTraits

      PATH = "#{APIActions::BASE_API_URL}/domain-traits"

      def list_domain_traits(listing_id)
        response = authenticated_api_get("#{Appilf::Listing.listing_path(listing_id)}#{PATH}")
        Appilf::Util.translate_from_response(response)
      end

    end

  end

end