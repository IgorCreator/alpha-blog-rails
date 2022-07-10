require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category_sport = Category.create(name: "Sports")
    @category_travel = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category_sport), text: @category_sport.name
    assert_select "a[href=?]", category_path(@category_travel), text: @category_travel.name
  end
end
