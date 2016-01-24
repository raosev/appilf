module Appilf

  class User < AppilfObject
    extend APIActions

    USER_PATH = "/users"

    def initialize(user_hash)
      super
    end


  end


end