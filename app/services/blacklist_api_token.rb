class BlacklistApiToken
  include Interactor

  def call
    token = context.token || parse_jwt_from_header
    context.blacklisted_token = blacklist_token(context.token)
  end

  private

  def blacklist_token(token)
    REDIS_CLIENT.set("blacklist:#{token}", 'true')
    REDIS_CLIENT.expire("blacklist:#{token}", 60 * 60 * 12)
    token
  end

  def parse_jwt_from_header
    if context.headers['Authorization'].present?
      jwt_token = context.headers['Authorization'].split(' ').last
    else
      context.error = 'Missing token'
      context.fail!
    end
  end
end
