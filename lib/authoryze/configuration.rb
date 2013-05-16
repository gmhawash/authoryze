module Authoryze
  # Stores configuration information
  #
  # Configuration information is loaded from a configuration block defined within
  # the client application.
  #
  # @example Standard settings
  #   Authroyze.configure do |c|
  #     c.resource_accessor = :current_user         # controller.current_user
  #     c.permission_collection = :permissions    # controller.current_user.permissions
  #   end
  #
  class Configuration
    class << self
      def define_setting(name)
        defined_settings << name
        attr_accessor name
      end

      def defined_settings
        @defined_settings ||= []
      end
    end

    define_setting :resource_accessor

    define_setting :permissions_collection

  end
end
