class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:lauren)
    @valid_token = JsonWebToken.encode(user_id: @user.id)
  end

  test "should get index" do
    get users_url, as: :json, headers: { 'Authorization' => @valid_token }
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { username: "dhh", first_name: "David", last_name: "Hansson", password: "cpciU9scr9!" } }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json, headers: { 'Authorization' => @valid_token }
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { first_name: "Laurie" } }, as: :json, headers: { 'Authorization' => @valid_token }
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json, headers: { 'Authorization' => @valid_token }
    end

    assert_response 204
  end
end
