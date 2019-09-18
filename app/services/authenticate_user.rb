class AuthenticateUser
  include Interactor

  def call
    user = authentication

    if user
      context.user = user
      context.token = JsonWebToken.encode(user_id: user.id)
    else
      context.fail!(message: 'invalid credentials')
    end
  end

  private

  def authentication
    user = User.find_by_username(context.username)
    correct_password = user ? user.authenticate(context.password) : false
    return user if user && correct_password
  end
end
