module Appilf

  class Object

    # attr_accessor :meta
    # attr_accessor :links
    attr_accessor :item_data

    def meta
      @meta ||= {}
    end

    def links
      @links ||= {}
    end

    def initialize(api_element_hash)
      initialize_meta_data(api_element_hash)
      self.item_data = api_element_hash['data'].methodize!; rescue NoMethodError
    end

    def initialize_meta_data(api_element_hash)
      self.meta = api_element_hash['data'].delete('meta').methodize!;  rescue NoMethodError
      self.links = api_element_hash['data'].delete('links').methodize!; rescue NoMethodError
    end

    def method_missing(name)
      self.item_data.send(name)
    end

  end

end