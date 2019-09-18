require 'test_helper'

class BlacklistApiTokenTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:andrew)
    @user2 = users(:lauren)
  end

  test 'blacklist token comes back true' do
    token = JsonWebToken.encode(user_id: @user1.id)
    BlacklistApiToken.call(token: token).success?
    result = CheckApiBlacklist.call(token: token)

    assert_equal true, result.success?
    assert_equal true, result.blacklisted
  end

  test 'valid token comes back false' do
    token = JsonWebToken.encode(user_id: @user2.id)
    result = CheckApiBlacklist.call(token: token)

    assert_equal true, result.success?
    assert_equal false, result.blacklisted
  end
end
