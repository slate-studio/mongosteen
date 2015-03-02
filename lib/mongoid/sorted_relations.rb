# NOTE: this is an updated version of mongoid-sorted-relations gem
#       https://github.com/demarque/mongoid-sorted-relations

# NOTE: the problem is that mongoid returnes object in random order
#       for relation queries, this patch stores relations ids order
#       and sort objects using cached order.

module Mongoid
  module SortedRelations
    extend ActiveSupport::Concern

    included do
      after_initialize :define_sorted_methods
      after_initialize :cache_relations_ids_order
      after_save       :cache_relations_ids_order
    end

    def define_sorted_methods
      self.relations.each do |key, relation|
        if [:has_many, :has_and_belongs_to_many].include? relation.macro
          self.class.send(:define_method, "sorted_#{relation.name}") do
            sorted_relation(relation)
          end
        end
      end
    end

    def cache_relations_ids_order
      @__sorted_relation_criterias = {}
      @__sorted_relation_ids       = {}

      self.relations.each do |key, relation|
        if [:has_many, :has_and_belongs_to_many].include? relation.macro
          relation_ids = self.send(relation.key)

          @__sorted_relation_ids[relation.key] = [ relation_ids ].flatten.map do |rid|
            rid.to_s
          end
        end
      end
    end

    def sorted_relation(relation)
      @__sorted_relation_criterias[relation.name] ||= sorted_related_criteria(relation)
    end

    def sorted_related_criteria(relation)
      related_documents = self.send(relation.name)

      sorted_documents = related_documents.sort_by do |x|
        @__sorted_relation_ids[relation.key].index(x.id.to_s)
      end

      return Mongoid::FakeCriteria.new(sorted_documents)
    end
  end
end




