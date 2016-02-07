module Appilf

  class Listing < AppilfObject
    extend APIActions
    extend PaginatedResource

    PATH = "/listings"

    def initialize(listing_hash)
      add_relationships(listing_hash['data'].delete('relationships'))
      super
    end

    def self.list
      response = api_get(PATH)
      set_page(response)
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