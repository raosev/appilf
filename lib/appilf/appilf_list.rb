module Appilf

  class AppilfList < AppilfObject
    include Enumerable

    attr_accessor :list_elements

    def list_elements
      @list_elements ||= []
    end

    def initialize(api_elements_hash)
      api_elements_hash['data'].each do |api_element_hash|
        self.list_elements << Util.translate_from_response({'data' => api_element_hash})
      end
    end

    def each(&block)
      self.list_elements.each(&block)
    end

  end

end