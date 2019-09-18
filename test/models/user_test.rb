require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(first_name: 'Courtney', last_name: 'Ipsum', username: 'cipsum', password: '6x2thNeXYb!' )
    assert user.valid?
  end

  test 'invalid without username' do
    user = User.new(first_name: 'Courtney', last_name: 'Ipsum', password: '6x2thNeXYb!' )
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:username], 'no validation error for name present'
  end

  test 'invalid with a duplicate username' do
    existing_user = users(:lauren)
    user = User.new(first_name: 'Lauren', last_name: 'Ipsum', username: 'lipsum', password: '6x2thNeXYb!' )
    refute user.valid?, 'user is valid with duplicate username'
    assert_not_nil user.errors[:username], 'no validation error for name present'
  end

  test 'invalid without password' do
    user = User.new(first_name: 'Courtney', last_name: 'Ipsum', username: 'cipsum')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end

  test 'invalid with simple password' do
    user = User.new(first_name: 'Courtney', last_name: 'Ipsum', username: 'cipsum', password: 'test')
    refute user.valid?
    assert_not_nil user.errors[:password]
  end

end
