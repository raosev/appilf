module Appilf

  class Client
    include APIActions
    include Authentication

    def initialize(opts={})
      opts.each_pair do |key, val|
        instance_variable_set(:"@#{key}", val)
      end
      authenticate if opts.present? && opts[:access_token].blank?
      self
    end

  end


end