require 'ostruct'

module Authoryze
module Rails
  module ControllerExtensions
    extend ActiveSupport::Concern

    included do
      class_eval do
        helper_method :can
      end
    end

    def can
      @__can_authoryze ||= OpenStruct.new begin
        if resource = send(Authoryze.resource_accessor)
          Hash[resource.send(Authoryze.permissions_collection).map{|x| ['%s?' % x,true]}]
        end
      end
    end

    module ClassMethods
      def authoryze!(*args)
        options = args.extract_options!
        filter = Authoryze::Rails::AuthoryzeFilter.new(self)
        self.before_filter(filter, options.slice(:only, :except, :if, :unless))
      end

      def can(*args)
        options = args.extract_options!
        filter = Authoryze::Rails::CanFilter.new(args)
        self.before_filter(filter, options.slice(:only, :except, :if, :unless))
      end
    end
  end
end
end

