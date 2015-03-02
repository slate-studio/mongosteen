module Reactor
  module ClassMethods
    def json_config(config_hash)
      self.as_json_config = config_hash
    end
  end
end