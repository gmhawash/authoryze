module Authoryze
  class AccessDenied < StandardError
    attr_reader :action, :subject
    attr_writer :default_message

    def initialize(message = nil, action = nil, subject = nil)
      @message = message
      @action = action
      @subject = subject
      @default_message = I18n.t(:"unauthorized.default", :default => "You are not authorized to access this page.")
    end

    def to_s
      @message || @default_message
    end
  end

  module ControllerExtensions
    extend ActiveSupport::Concern
    class Filter
      def initialize(permissions)
        @permissions = permissions
      end

      def filter(controller)
        @permissions.each do |permission|
          unless controller.can.send("#{permission}?")
            raise AccessDenied, "Permission '#{permission}' is not allowed for current user"
          end
        end
      end
    end

    class Permissions < OpenStruct
      def method_missing(method, *args)
        return false
      end
    end

    # Make it available in view
    included do
      class_eval do
        helper_method :can
      end
    end

    def can
      @__can_authoryze ||= Permissions.new begin
        if respond_to?(:current_user) && current_user
          current_user.roles.map(&:permissions).inject({}) {|r,e| r.merge(e)}
        end
      end
    end

    module ClassMethods
      def can(*args)
        options = args.extract_options!
        filter = Filter.new(args)
        self.before_filter(filter, options.slice(:only, :except, :if, :unless))
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Authoryze::ControllerExtensions
  end
end
