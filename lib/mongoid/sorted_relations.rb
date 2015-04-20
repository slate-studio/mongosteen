# =============================================================================
# class Book
#   include Mongoid::Document
#   include Mongoid::SortedRelations
#
#   field :title
#
#   has_many :chapters
#   sorted_relations_for :chapters
#
#   has_and_belongs_to_many :authors
#   sorted_relations_for :authors
# end
#
# b = Book.create('Hello')
#
# b.sorted_chapter_ids = [ Chapter.create(:title => 'The End').id,
#                          Chapter.create(:title => 'Part 3').id,
#                          Chapter.create(:title => 'Part 2').id,
#                          Chapter.create(:title => 'Part 1').id,
#                          Chapter.create(:title => 'Intro').id ]
#
# b.sorted_chapters()
#
# book.sorted_author_ids = [ Author.create(:name => 'Sun Tzu').id,
#                            Author.create(:name => 'Sun Wu').id,
#                            Author.create(:name => 'Lao Zi').id ]
#
# book.sorted_authors()
#
# =============================================================================

module Mongoid
  module SortedRelations
    extend ActiveSupport::Concern

    class_methods do

      def sorted_relations_for(relation_name)
        relation = self.relations[relation_name.to_s]

        if relation.macro == :has_and_belongs_to_many
          define_has_and_belongs_to_many_sorted_methods(relation)
        end

        if relation.macro == :has_many
          define_has_many_sorted_methods(relation)
        end
      end


      # =====================================================
      # HAS_AND_BELONGS_TO_MANY
      #

      def define_has_and_belongs_to_many_sorted_methods(relation)
        # connect object instance method: sorted_#{ relation.name }
        self.send(:define_method, "sorted_#{ relation.name }") do
          related_documents   = self.send(relation.name)
          sorted_relation_ids = self.send("#{ relation.name.to_s.singularize }_ids").map { |id| id.to_s }

          sorted_documents = related_documents.sort_by do |document|
            sorted_relation_ids.index(document.id.to_s)
          end

          return Mongoid::FakeCriteria.new(sorted_documents)
        end

        # connect object instance setter: sorted_#{ relation.name } = [Array]
        self.send(:define_method, "sorted_#{ relation.name.to_s.singularize }_ids=") do |ids|
          self.send("#{ relation.name.to_s.singularize }_ids=", ids)
        end
      end


      # =====================================================
      # HAS_MANY
      #

      def define_has_many_sorted_methods(relation)
        # define field to store order for has_many related documents,
        self.field "_sorted_#{ relation.name.to_s.singularize }_ids", :type => Array, default: []

        # sorted_#{ relation.name }
        self.send(:define_method, "sorted_#{ relation.name }") do
          related_documents   = self.send(relation.name)
          sorted_relation_ids = self["_sorted_#{ relation.name.to_s.singularize }_ids"].map { |id| id.to_s }

          # @TODO: add workaround for missing or extra ids
          sorted_documents = related_documents.sort_by do |document|
            sorted_relation_ids.index(document.id.to_s)
          end

          return Mongoid::FakeCriteria.new(sorted_documents)
        end

        # sorted_#{ relation.name } = [Array of ids]
        self.send(:define_method, "sorted_#{ relation.name.to_s.singularize }_ids=") do |ids|
          ids = ids.map{ |id| id.to_s }

          self.update_attributes({
            "_sorted_#{ relation.name.to_s.singularize }_ids" => ids, # store order
            "#{ relation.name.to_s.singularize }_ids" => ids # update relations
          })
        end
      end

    end
  end
end




