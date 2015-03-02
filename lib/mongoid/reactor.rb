module Mongoid
  module Reactor
    extend ActiveSupport::Concern

    def serializable_hash(options={})
      attrs = super(options)
      attrs.each_pair do |k, v|
        if k.end_with?('_id')
          attrs[k] = v.to_s
        end

        if k.end_with?('_ids')
          attrs[k] = attrs[k].collect { |id| id.to_s }
        end
      end
      attrs
    end
  end
end