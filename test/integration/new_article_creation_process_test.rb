require 'test_helper'

class NewArticleCreationProcessTest < ActionDispatch::IntegrationTest
  test "get new article form and create it" do
    @title = "test_title"
    @description = "test_description"

    sing_in_as_user
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: @title, description: @description } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match @title, response.body
    assert_match @description, response.body
  end

  test "get empty article form and reject invalid submission" do
    sing_in_as_user
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ", description: " ", category_ids: [] } }
    end
    assert_select "div.alert"
    assert_select "h4.alert-heading"
    assert_match "errors", response.body
  end
end
