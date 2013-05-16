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
        if respond_to?(:current_user) && current_user
          current_user.roles.map(&:permissions).inject({}) {|r,e| r.merge(e)}
        end
      end
    end

    module ClassMethods
      def can(*args)
        options = args.extract_options!
        filter = Authoryze::Rails::Filter.new(args)
        self.before_filter(filter, options.slice(:only, :except, :if, :unless))
      end
    end
  end
end
end

