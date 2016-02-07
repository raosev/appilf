module Appilf

  class AppilfObject

    attr_accessor :meta
    attr_accessor :links
    attr_accessor :item_data

    def meta
      @meta ||= {}
    end

    def links
      @links ||= {}
    end

    def item_data
      @item_data ||= {}
    end

    def initialize(api_element_hash)
      init_meta_data(api_element_hash)
      self.item_data = api_element_hash.fetch('data', {}).methodize!
    end

    def init_meta_data(api_element_hash)
      self.meta = api_element_hash.fetch('data', {}).delete('meta')
      self.links = api_element_hash.fetch('data', {}).delete('links')
      self.meta.methodize!
      self.links.methodize!
    end

    def respond_to_missing?(method_name, include_private = false)
      item_data.keys.include? method_name
    end

    def method_missing(method_name, *args)
      item_data.send(method_name)
    end

  end

end