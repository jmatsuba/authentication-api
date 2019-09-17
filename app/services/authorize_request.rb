class AuthorizeRequest
  include Interactor

  def call
    parse_jwt_from_header
    decode_auth_token
    lookup_user
  end

  private

  def parse_jwt_from_header
    if context.headers['Authorization'].present?
      @jwt_token = context.headers['Authorization'].split(' ').last
    else
      context.error = "Missing token"
      context.fail!
    end
    nil
  end

  def decode_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(@jwt_token)
  end

  def lookup_user
    @user ||= User.find(@decoded_auth_token[:user_id]) if @decoded_auth_token
    if @user
      context.user = @user
    else
      context.error = "Invalid token"
      context.fail!
    end
  end

end
