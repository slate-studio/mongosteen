require 'test_helper'

class ApiTest < Capybara::Rails::TestCase
  test 'create test item' do
    page.driver.post('/test_items', { params: { title: 'Test title', description: 'Test description'} })

    assert_equals(1, TestItem.count)
    assert_equals('Test title', TestItem.first.title)
    assert_equals('Test description', TestItem.first.description)
  end

  test 'update test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')

    page.driver.patch("/test_items/#{TestItem.first.id}", { params: { title: 'Test title 2', description: 'Test description 2'} })
    assert_equals('Test title 2', TestItem.first.title)
    assert_equals('Test description 2', TestItem.first.description)
  end

  test 'show test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')

    visit "/test_items/#{TestItem.first.id}"
    test_item_hash = JSON.parse(page.body)
    assert_equals('Test title', test_item_hash["title"])
    assert_equals('Test description', test_item_hash["description"])
  end

  test 'index test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')
    TestItem.create!(title: 'Test title 2', description: 'Test description 2')

    visit '/test_items'

    test_item_array = JSON.parse(page.body)

    assert_equals('Test title', test_item_array[0]["title"])
    assert_equals('Test description', test_item_array[0]["description"])

    assert_equals('Test title 2', test_item_array[1]["title"])
    assert_equals('Test description 2', test_item_array[1]["description"])
  end

  test 'pagination' do
    (0..2).each do |index|
      TestItem.create!(title: "Test title #{index}", description: "Test description #{index}")
    end

    visit '/test_items?perPage=2&page=1'

    test_item_array = JSON.parse(page.body)
    assert_equals(2, test_item_array.length)
  end

  test 'search' do
    (0..2).each do |index|
      TestItem.create!(title: "Test title #{index}", description: "Test description #{index}")
    end

    TestItem.create!(title: "Mongosteen", description: "Mongosteen description")

    visit '/test_items?search=Mongosteen'

    test_item_array = JSON.parse(page.body)
    assert_equals(1, test_item_array.length)
    assert_equals('Mongosteen', test_item_array[0]['title'])
  end

  test 'search' do
    TestItem.create!(title: "Test title", description: "Test description")
    TestItem.create!(title: "Test title 2", description: "Test description 2")

    visit '/test_items?scope=test_scope'

    test_item_array = JSON.parse(page.body)
    assert_equals(1, test_item_array.length)
    assert_equals('Test title', test_item_array[0]['title'])
  end
end
