require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(first_name: 'Lauren', last_name: 'Ipsum', username: 'lipsum', password: '6x2thNeXYb!' )
    assert user.valid?
  end

  test 'invalid without username' do
    user = User.new(first_name: 'Lauren', last_name: 'Ipsum', password: '6x2thNeXYb!' )
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:username], 'no validation error for name present'
  end

  test 'invalid without password' do
    user = User.new(first_name: 'Lauren', last_name: 'Ipsum', username: 'lipsum')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end

  test 'invalid with simple password' do
    user = User.new(first_name: 'Lauren', last_name: 'Ipsum', username: 'lipsum', password: 'test')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end

end
