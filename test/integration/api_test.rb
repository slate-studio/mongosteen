require 'test_helper'

class ApiTest < Capybara::Rails::TestCase
  test 'create test item' do
    page.driver.post('/test_items', { test_item: { title: 'Test title', description: 'Test description'} } )

    assert_equal(1, TestItem.count)
    assert_equal('Test title', TestItem.first.title)
    assert_equal('Test description', TestItem.first.description)
  end

  test 'update test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')

    page.driver.put("/test_items/#{TestItem.first.id}", { test_item: { title: 'Test title 2', description: 'Test description 2'} })
    assert_equal('Test title 2', TestItem.first.title)
    assert_equal('Test description 2', TestItem.first.description)
  end

  test 'show test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')

    visit "/test_items/#{TestItem.first.id}.json"
    test_item_hash = JSON.parse(page.body)
    assert_equal('Test title', test_item_hash["title"])
    assert_equal('Test description', test_item_hash["description"])
  end

  test 'index test item' do
    TestItem.create!(title: 'Test title', description: 'Test description')
    TestItem.create!(title: 'Test title 2', description: 'Test description 2')

    visit '/test_items.json'

    test_item_array = JSON.parse(page.body)

    assert_equal('Test title', test_item_array[0]["title"])
    assert_equal('Test description', test_item_array[0]["description"])

    assert_equal('Test title 2', test_item_array[1]["title"])
    assert_equal('Test description 2', test_item_array[1]["description"])
  end

  test 'pagination' do
    (0..2).each do |index|
      TestItem.create!(title: "Test title #{index}", description: "Test description #{index}")
    end

    visit '/test_items.json?perPage=2&page=1'

    test_item_array = JSON.parse(page.body)
    assert_equal(2, test_item_array.length)
  end

  test 'search' do
    (0..2).each do |index|
      TestItem.create!(title: "Test title #{index}", description: "Test description #{index}")
    end

    TestItem.create!(title: "Mongosteen", description: "Mongosteen description")

    visit '/test_items.json?search=Mongosteen'

    test_item_array = JSON.parse(page.body)
    assert_equal(1, test_item_array.length)
    assert_equal('Mongosteen', test_item_array[0]['title'])
  end

  test 'scope' do
    TestItem.create!(title: "Test title", description: "Test description")
    TestItem.create!(title: "Test title 2", description: "Test description 2")

    visit '/test_items.json?test_scope=true'

    test_item_array = JSON.parse(page.body)
    assert_equal(1, test_item_array.length)
    assert_equal('Test title', test_item_array[0]['title'])
  end

  test 'test method' do
    TestItem.create!(title: "Test title", description: "Test description")

    visit '/test_items.json'

    test_item_array = JSON.parse(page.body)
    assert_equal('Test method', test_item_array[0]['test_method'])
  end

  test 'test permit params' do
    page.driver.post('/test_permit_items', { test_permit_item: { title: 'Test title', description: 'Test description'} } )

    assert_equal('Test title', TestPermitItem.first.title)
    assert_equal(nil, TestPermitItem.first.description)
  end
end
