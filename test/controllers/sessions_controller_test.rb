require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "correct login attempt should get a success" do
    user = users(:lauren)
    post sessions_url, params: { session: { username: user.username, password: '6x2thNeXYb!' } }
    assert_response :success
  end


  test "incorrect login attempt should get a unauthorized" do
    user = users(:lauren)
    post sessions_url, params: { session: { username: user.username, password: 'helloworld' } }
    assert_response :unauthorized
  end

end
