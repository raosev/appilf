module Appilf

  class ResourcePage < AppilfObject
    include Enumerable
    include APIActions

    attr_accessor :items
    attr_accessor :page_meta
    attr_accessor :page_links

    # :page_number , :page_size, :total_results
    def page_meta
      @page_meta ||= {}
    end

    # :prev, :next
    def page_links
      @page_links ||= {}
    end

    def next
      get_page(page_links.next)
    end

    def previous
      get_page(page_links.prev)
    end

    def items
      @items ||= []
    end

    def initialize(paginated_response)
      init_page_meta_data(paginated_response)
      paginated_response['data'].each do |api_element_data_hash|
        self.items << Util.translate_from_response({'data' => api_element_data_hash})
      end
    end

    def each(&block)
      self.items.each(&block)
    end

    private

    def get_page(link)
      return unless link
      response = api_get(link)
      Util.translate_from_response(response)
      # set_page(response)
    end

    def init_page_meta_data(api_element_hash)
      self.page_meta = api_element_hash.fetch('meta', {})
      self.page_links = api_element_hash.fetch('links', {})
      self.page_meta.methodize!
      self.page_links.methodize!
    end

  end

end