module Authoryze
module Rails
  class Filter
    def initialize(permissions)
      @permissions = permissions
    end

    def filter(controller)
      @permissions.each do |permission|
        unless controller.can.send("#{permission}?")
          raise Authoryze::AccessDenied, "Permission '#{permission}' is not allowed for current user"
        end
      end
    end
  end
end
end

