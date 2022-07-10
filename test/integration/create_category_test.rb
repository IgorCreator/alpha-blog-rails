require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    sing_in_as_admin
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "sports" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "sports", response.body
  end

  test "get empty category form and reject invalid submission" do
    sing_in_as_admin
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " } }
    end
    assert_select "div.alert"
    assert_select "h4.alert-heading"
    assert_match "errors", response.body
  end
end
