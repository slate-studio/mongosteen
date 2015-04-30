require 'inherited_resources'
require 'has_scope'
require 'kaminari'

module Mongosteen
  autoload :Actions,         'mongosteen/actions'
  autoload :ClassMethods,    'mongosteen/class_methods'
  autoload :BaseHelpers,     'mongosteen/base_helpers'
  autoload :PermittedParams, 'mongosteen/permitted_params'

  class Engine < ::Rails::Engine
    require 'mongosteen/engine'
    require 'mongoid/fake_criteria'
    require 'mongoid/sorted_relations'
    require 'mongoid/serializable_id'
  end
end


class ActionController::Base
  # You can call mongosteen in your controller to have
  # all the required modules and funcionality included.
  def self.mongosteen
    self.class_eval do
      inherit_resources

      respond_to :json
      class_attribute :as_json_config
      class_attribute :json_default_methods

      extend  Mongosteen::ClassMethods
      include Mongosteen::BaseHelpers
      include Mongosteen::Actions
      include Mongosteen::PermittedParams

      instance_name = self.resources_configuration[:self][:instance_name]

      # configure permitted_params to accept all attributes
      define_method("#{ instance_name }_params") { params_all_permitted }
      private "#{ instance_name }_params"

      # support for character default list item attributes
      chr_default_methods = %w( _list_item_title _list_item_subtitle _list_item_thumbnail )
      self.json_default_methods = chr_default_methods.select { |m| self.resource_class.method_defined? m }

      json_config()

    end
  end
end

# TODO: take a look at http://jsonapi.org/implementations/


