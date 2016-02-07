module Appilf

  class WatchedItem < AppilfObject

    def initialize(watched_item_hash)
      add_relationships(watched_item_hash['data'].delete('relationships'))
      super
    end

  end

end