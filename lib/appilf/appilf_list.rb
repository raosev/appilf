module Appilf

  class AppilfList < AppilfObject
    include Enumerable

    def elements
      @elements ||= []
    end

    def initialize(api_elements_hash)
      self.meta = api_element_hash.delete('meta').methodize!; rescue NoMethodError
      self.links = api_element_hash.delete('links').methodize!; rescue NoMethodError
      api_elements_hash['data'].each do |api_element_hash|
        self.elements << Util.translate_from_response(api_element_hash)
      end
    end

    def each
      self.elements.each do |element|
        yield element
      end
    end

  end

end