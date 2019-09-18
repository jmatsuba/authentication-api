require 'test_helper'

class BlacklistApiTokenTest < ActiveSupport::TestCase
  test 'blacklist a token' do
    user = users(:mike)
    token = JsonWebToken.encode(user_id: user.id)
    result = BlacklistApiToken.call(token: token)

    assert_equal true, result.success?
    assert_equal token, result.blacklisted_token
    assert_equal 'true', REDIS_CLIENT.get("blacklist:#{token}")
  end
end
