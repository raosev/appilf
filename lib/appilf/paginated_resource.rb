module Appilf

  module PaginatedResource

    # page_meta vars
    attr_accessor :page_number , :page_size, :total_results

    # page_links vars
    attr_accessor :prev, :next

    #
    attr_accessor :data

    def set_page(paginated_response)
      page_meta = paginated_response['meta']
      page_links = paginated_response['links']
      page_meta.merge(page_links).keys.each do |page_var|
        instance_variable_set(:"@#{page_var}", page_meta["#{page_var}"])
      end
    end







  end


end