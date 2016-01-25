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
      initialize_meta_data(api_element_hash)
      self.item_data = api_element_hash.fetch('data', {}).methodize!
    end

    def initialize_meta_data(api_element_hash)
      self.meta = api_element_hash.fetch('data', {}).delete('meta')
      self.links = api_element_hash.fetch('data', {}).delete('links')
      self.meta.methodize!
      self.links.methodize!
    end

    def method_missing(name)
      return self.item_data.send(name) if self.item_data
      super
    end

  end

end