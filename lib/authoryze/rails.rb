if defined?(Rails) &&  defined?(ActionController::Base)
  require 'authoryze/rails/controller_extensions'
  require 'authoryze/rails/filter'

  ActionController::Base.class_eval do
    include Authoryze::Rails::ControllerExtensions
  end
end
