module Mongosteen
  module ClassMethods
    def json_config(config_hash={})
      config_hash[:methods] ||= []
      config_hash[:methods].concat(json_default_methods).uniq!
      self.as_json_config = config_hash
    end
  end
end
