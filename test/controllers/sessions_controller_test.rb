require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:lauren)
  end

  test 'correct login attempt should get a success' do
    post sessions_url, params: { session: { username: @user.username, password: '6x2thNeXYb!' } }
    assert_response :success
  end

  test 'incorrect login attempt should get a unauthorized' do
    post sessions_url, params: { session: { username: @user.username, password: 'helloworld' } }
    assert_response :unauthorized
  end

  test 'users can logout and get a api key blacklisted' do
    valid_token = JsonWebToken.encode(user_id: @user.id)
    delete sessions_url, headers: { "Authorization": valid_token }
    assert_response :success
  end
end
