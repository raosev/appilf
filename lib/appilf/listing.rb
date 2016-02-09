module Appilf

  class Listing < AppilfObject
    extend APIActions

    PATH = "#{APIActions::BASE_API_URL}/listings"

    def initialize(listing_hash)
      add_relationships(listing_hash['data'].delete('relationships'))
      super
    end

    def self.list(params = {})
      response = api_get(PATH, params: Appilf::Util.parse_query_params(params))
      Appilf::Util.translate_from_response(response)
    end

    def self.retrieve(listing_id)
      response = api_get("#{PATH}/#{listing_id}")
      Appilf::Util.translate_from_response(response)
    end

    def self.listing_path(listing_id)
      "#{PATH}/#{listing_id}"
    end

  end

end