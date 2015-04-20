require 'spec_helper'

describe Mongoid::SortedRelations do

  context "Having the book The Art of War" do
    let(:book) { Book.new(:title => 'The Art of War') }

    context "written by the authors Lao Zi, Sun Wu and Sun Tzu." do
      before { book.sorted_author_ids = [ Author.create(:name => 'Sun Tzu').id,
                                          Author.create(:name => 'Sun Wu').id,
                                          Author.create(:name => 'Lao Zi').id ] }
      before { book.save and book.reload }
      before { book.sorted_author_ids = book.author_ids.map { |id| id.to_s }.reverse }

      the("book.sorted_authors.map(&:name)") { should eql ['Lao Zi', 'Sun Wu', 'Sun Tzu'] }
    end
  end


  context "Having the book War and Piece" do
    let(:book) { Book.create(:title => 'War and Piece') }

    context "to have chapters Intro, Part 1, Part 2, Part 3 and The End." do
      before { book.sorted_chapter_ids = [ Chapter.create(:title => 'The End').id,
                                           Chapter.create(:title => 'Part 3').id,
                                           Chapter.create(:title => 'Part 2').id,
                                           Chapter.create(:title => 'Part 1').id,
                                           Chapter.create(:title => 'Intro').id ] }
      before { book.reload }
      before { book.sorted_chapter_ids = book.chapter_ids.map { |id| id.to_s }.reverse }

      the("book.sorted_chapters.map(&:title)") { should eql ['Intro', 'Part 1', 'Part 2', 'Part 3', 'The End'] }
    end
  end

end
