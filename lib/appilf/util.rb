module Appilf

  module Util

    def self.translate_from_response(response_data)
      if response_data['data'].is_a? Array
        AppilfList.new(response_data)
      else
        object_from_response_item(response_data)
      end
    end


    def self.object_from_response_item(response_item)
      flippa_type = response_item['data']
      flippa_type = flippa_type.fetch('type', nil) if flippa_type
      flippa_class_mapping(flippa_type).send(:new, response_item)
    end


    def self.flippa_class_mapping(flippa_type)
      @flippa_class_mappings ||= {
          'listings' => Appilf::Listing,
          'users' => Appilf::User,
          'domain-traits' => Appilf::DomainTrait
      }
      @flippa_class_mappings[flippa_type] || AppilfObject
    end

  end


end