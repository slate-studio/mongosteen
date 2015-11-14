module Mongosteen
  module ClassMethods
    def json_config(config_hash={})
      self.as_json_config_actions = {}
      actions = config_hash.delete(:actions) || {}

      set_json_actions(actions)
      set_json_default(config_hash)
    end

    def csv_config(config_hash={})
      self.as_csv_config = config_hash
    end

    private

    def set_json_actions(config)
      config.each do |k, v|
        v[:methods] ||= []
        v[:methods].concat(json_default_methods).uniq!
      end
      self.as_json_config_actions = config
    end

    def set_json_default(config)
      config[:methods] ||= []
      config[:methods].concat(json_default_methods).uniq!
      self.as_json_config = config
    end
  end
end
