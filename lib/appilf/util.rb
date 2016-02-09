module Appilf

  module Util

    @pagination_params_map = {
        page_number: 'page[number]',
        page_size: 'page[size]'
    }


    def self.translate_from_response(response_data)
      if response_data['data'].is_a?(Array) && paginated_resource?(response_data)
        Appilf::ResourcePage.new(response_data)
      elsif response_data['data'].is_a?(Array)
        array_from_response_item(response_data)
      else
        object_from_response_item(response_data)
      end
    end


    def self.array_from_response_item(api_elements_hash)
      items = []
      api_elements_hash['data'].each do |api_element_hash|
        items << translate_from_response({'data' => api_element_hash})
      end
      items
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
          'domain-traits' => Appilf::DomainTrait,
          'watched-items' => Appilf::WatchedItem,
          'saved-searches' => Appilf::SavedSearch
      }
      @flippa_class_mappings[flippa_type] || AppilfObject
    end

    def self.parse_query_params(params = {})
      @pagination_params_map.each_pair do |old_key,new_key|
        original_value = params.delete(old_key)
        next unless original_value
        params[new_key] = original_value
      end
      params
    end

    def self.paginated_resource?(response_data)
      page_links = response_data.fetch('links', nil)
      return false unless page_links
      page_links.keys.include?('prev') && page_links.keys.include?('next')
    end

  end


end