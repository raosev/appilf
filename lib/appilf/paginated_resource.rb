module Appilf

  module PaginatedResource

    attr_accessor :page_meta
    attr_accessor :page_links
    attr_accessor :current_data

    # :page_number , :page_size, :total_results
    def page_meta
      @page_meta ||= {}
    end

    # :prev, :next
    def page_links
      @page_links ||= {}
    end

    def next
      navigate_page(page_links.next)
    end

    def previous
      navigate_page(page_links.prev)
    end

    attr_accessor :current_data

    def set_page(paginated_response)
      init_page_meta_data(paginated_response)
      self.current_data = Appilf::Util.translate_from_response(paginated_response)
    end

    def init_page_meta_data(api_element_hash)
      self.page_meta = api_element_hash.fetch('meta', {})
      self.page_links = api_element_hash.fetch('links', {})
      self.page_meta.methodize!
      self.page_links.methodize!
    end

    private

    def navigate_page(link)
      raise NonExistentPage.new("Cannot navigate to non existent page") unless link
      response = api_get(link)
      set_page(response)
    end


  end

end