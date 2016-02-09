require 'appilf/client/users'
require 'appilf/client/alerts'
require 'appilf/client/domain_traits'
require 'appilf/client/saved_searches'
require 'appilf/client/watched_items'

module Appilf

  class Client
    include Appilf::APIActions
    include Appilf::Authentication
    include Appilf::Client::Users
    include Appilf::Client::Alerts
    include Appilf::Client::DomainTraits
    include Appilf::Client::SavedSearches
    include Appilf::Client::WatchedItems

    def initialize(opts={})
      opts.each_pair do |key, val|
        instance_variable_set(:"@#{key}", val)
      end
      authenticate if opts && !opts[:access_token]
      self.user = retrieve_user
      self
    end

    def authenticated_api_get(path, headers = {})
      api_get(path, headers.merge(authentication_headers))
    end

    def authenticated_api_post(path, payload, headers = {})
      api_post(path, payload, headers.merge(authentication_headers))
    end

    def authenticated_api_delete(path, payload, headers = {})
      api_delete(path, payload, headers.merge(authentication_headers))
    end

  end


end