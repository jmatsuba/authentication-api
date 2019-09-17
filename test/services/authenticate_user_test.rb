require 'test_helper'

class AuthenticateUserTest < ActiveSupport::TestCase
  test 'valid authentication attempt' do
    user = users(:lauren)
    result = AuthenticateUser.call(username: user.username, password: '6x2thNeXYb!')

    assert_equal true, result.success?
    assert_equal user, result.user
    assert_equal user.id, JsonWebToken.decode(result.token)[:user_id]
  end

  test 'invalid authentication attempt' do
    user = users(:lauren)
    result = AuthenticateUser.call(username: user.username, password: 'wrong-password')

    assert_equal false, result.success?
    assert_nil result.token
  end

end
