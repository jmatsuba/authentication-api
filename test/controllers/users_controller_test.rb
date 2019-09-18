class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { username: "dhh", first_name: "David", last_name: "Hansson", password: "cpciU9scr9!" } }, as: :json
    end

    assert_response 201
  end

  test "should not create a duplicate user" do
    existing_user = users(:lauren)
    post users_url, params: { user: { username: "lipsum", first_name: "Lauren", last_name: "Ipsum", password: "cpciU9scr9!" } }, as: :json

    assert_response 422
  end

end
