# NOTE: this is required by sorted_relations.rb
module Mongoid
  class FakeCriteria
    def initialize(documents)
      @documents = documents
    end

    def limit(quantity)
      Mongoid::FakeCriteria.new(@documents[0..quantity-1])
    end

    def raw
      @documents
    end

    def as_json(options={})
      @documents.as_json(options)
    end

    def method_missing(*args, &block)
      @documents.send(*args, &block)
    end
  end
end
