module Authoryze
module Rails
  def self.setup
    if defined?(::Rails) &&  defined?(::ActionController::Base)
      require 'authoryze/rails/controller_extensions'
      require 'authoryze/rails/can_filter'
      require 'authoryze/rails/authoryze_filter'

      ActionController::Base.class_eval do
        include Authoryze::Rails::ControllerExtensions
      end
    end
  end
end
end

Authoryze::Rails.setup

