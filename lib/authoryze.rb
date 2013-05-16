require "forwardable"
require 'authoryze/version'
require 'authoryze/rails'
require 'authoryze/exceptions'
require 'authoryze/configuration'

module Authoryze
  class << self
    extend Forwardable
    Configuration.defined_settings.each do |setting|
      def_delegators :configuration, setting, "#{setting.to_s}="
    end

    # @public
    # Returns the global configuration, or initializes a new configuration
    # object if it doesn't exist yet.
    #
    def configuration
      @configuration ||= Authoryze::Configuration.new
    end

    # @public
    # Yields the global configuration to a block.
    # @yield [configuration] global configuration
    #
    # @example
    #   Authoryze.configure do |c|
    #     c.root = 'path/to/ruote/assets'
    #   end
    # @see Authoryze::Configuration
    def configure(&block)
      unless block
        raise ArgumentError.new("You tried to .configure without a block!")
      end
      yield configuration
    end
  end
end

