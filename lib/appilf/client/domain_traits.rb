module Appilf

  class Client

    module DomainTraits

      def list_domain_traits(listing_id)
        response = authenticated_api_get(domain_traits_path(listing_id))
        Appilf::Util.translate_from_response(response)
      end

      def domain_traits_path(listing_id)
        "#{Appilf::Listing.listings_path(listing_id)}/domain-traits"
      end

    end

  end

end