require 'test_helper'

class AuthorizeRequestTest < ActiveSupport::TestCase
  setup do
    @user = users(:lauren)
  end

  test 'valid headers' do
    valid_token = JsonWebToken.encode(user_id: @user.id)

    # TODO: find proper way to mock action dispatch header
    headers = { Authorization: valid_token }.with_indifferent_access
    result = AuthorizeRequest.call(headers: headers)

    assert_equal true, result.success?
    assert_equal @user, result.user
  end

  test 'invalid headers' do
    invalid_token = 'abcd'

    # TODO: find proper way to mock action dispatch header
    headers = { Authorization: invalid_token }.with_indifferent_access
    result = AuthorizeRequest.call(headers: headers)

    assert_equal false, result.success?
    assert_nil result.user
  end
end
