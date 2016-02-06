module Appilf

  module Alert

    ALERTS_PATH = "/alerts"

    def self.list
      response = api_get(ALERTS_PATH)
      set_page(response)
    end

    def self.retrieve(listing_id)
      response = api_get("#{LISTING_PATH}/#{listing_id}")
      new(response)
    end


    def add_relationships(relationships_hash)
      self.class.instance_eval do
        relationships_hash.each_pair do |k, v|
          define_method(k) { Util.translate_from_response(v) }
        end
      end
    end

  end

end