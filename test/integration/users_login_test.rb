require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {email: "", password: ""}}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end
end
