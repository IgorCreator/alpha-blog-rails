require 'test_helper'

class UserSignUpProcessTest < ActionDispatch::IntegrationTest

  test "sign up a new user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "test", email: "test@gmail.com", password: "pwd" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end

  test "sign up an existing user" do
    @new_user = User.create(username: "test", email: "test@gmail.com", password: "pwd")

    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: @new_user.username, email: @new_user.email, password: "pwd" } }
    end
    assert_select "div.alert"
    assert_select "h4.alert-heading"
    assert_match "has already been taken", response.body
  end

  test "get invalid sign up form and reject submission" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: " ", email: " ", password: " " } }
    end
    assert_select "div.alert"
    assert_select "h4.alert-heading"
    assert_match "errors", response.body
  end

end
