module Appilf

  class Listing < AppilfObject
    extend APIActions

    PATH = "/listings"

    def initialize(listing_hash)
      add_relationships(listing_hash['data'].delete('relationships'))
      super
    end

    def self.list(params = {})
      response = api_get(listings_path, params: Appilf::Util.parse_query_params(params))
      Appilf::Util.translate_from_response(response)
    end

    def self.retrieve(listing_id)
      response = api_get(listings_path(listing_id))
      Appilf::Util.translate_from_response(response)
    end

    def self.listings_path(listing_id = nil)
      "#{APIActions::BASE_API_URL}#{PATH}/#{listing_id}"
    end

  end

end