# CodeKit needs relative paths
dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

module Reactor
  autoload :Actions,         'reactor/actions'
  autoload :ClassMethods,    'reactor/class_methods'
  autoload :BaseHelpers,     'reactor/base_helpers'
  autoload :PermittedParams, 'reactor/permitted_params'

  class Engine < ::Rails::Engine
    require 'reactor/engine'
  end
end

class ActionController::Base
  # You can call reactor_resources in your controller to have
  # all the required modules and funcionality included.
  def self.reactor_resources
    self.class_eval do
      inherit_resources

      respond_to :json
      class_attribute :as_json_config

      extend  Reactor::ClassMethods
      include Reactor::BaseHelpers
      include Reactor::Actions
      include Reactor::PermittedParams

      # configure permitted_params to accept all attributes
      instance_name = self.resources_configuration[:self][:instance_name]
      define_method("#{ instance_name }_params") { params_all_permitted }
      private "#{ instance_name }_params"
    end
  end
end




