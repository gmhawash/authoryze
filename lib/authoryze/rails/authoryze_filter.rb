module Authoryze
module Rails
  class AuthoryzeFilter
    def initialize(controller_class)
      @controller_name = controller_class.controller_name
    end

    def filter(controller)
      @controller = controller
      unless matches_permission?
        raise Authoryze::AccessDenied, "Permission '#{action}' is not allowed for current user"
      end
    end

    private
    def matches_permission?
      [:manage, action].any? do |permission|
        permission = "%s_%s?" % [permission, @controller_name]
        @controller.can.respond_to?(permission) &&
        @controller.can.send(permission)
      end
    end

    def action
      @action ||= {
        :index => :read,
        :show => :read,
        :new => :create,
        :create => :create,
        :edit => :update,
        :update => :update,
      }[@controller.request.parameters['action'].to_sym]
    end
  end
end
end

