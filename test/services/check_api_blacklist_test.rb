require 'test_helper'

class BlacklistApiTokenTest < ActiveSupport::TestCase
  setup do
    @user = users(:andrew)
  end

  test 'blacklist token comes back true' do
    token = JsonWebToken.encode(user_id: @user.id)
    BlacklistApiToken.call(token: token).success?
    result = CheckApiBlacklist.call(token: token)

    assert_equal true, result.success?
    assert_equal true, result.blacklisted
  end

  test 'valid token comes back false' do
    token = JsonWebToken.encode(user_id: @user.id)
    result = CheckApiBlacklist.call(token: token)

    assert_equal true, result.success?
    assert_equal true, result.blacklisted
  end

end
