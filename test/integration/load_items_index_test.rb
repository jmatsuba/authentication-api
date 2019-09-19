require 'test_helper'

class LoadItemsIndexTest < ActionDispatch::IntegrationTest
  setup do
    @item_one = items(:one)
    @item_two = items(:two)
  end

  test "create user and get the index of items" do
    post users_url, params: { user: { username: 'dhh', first_name: 'David', last_name: 'Hansson', password: 'cpciU9scr9!' } }, as: :json
    assert_response :created

    post sessions_url, params: { session: { username: 'dhh', password: 'cpciU9scr9!' } }
    assert_response :success
    auth_token = response.parsed_body['auth_token']

    get items_url, headers: { "Authorization": auth_token }
    assert_response :success
    assert_equal 2, response.parsed_body.length
    assert_equal @item_one.name, response.parsed_body.first['name']
  end

  test "unauthorized request for index of items" do
    get items_url
    assert_response :unauthorized
  end

end
