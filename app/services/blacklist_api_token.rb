class BlacklistApiToken
  include Interactor

  def call
    context.blacklisted_token = blacklist_token(context.token)
  end

  private

  def blacklist_token(token)
    REDIS_CLIENT.set("blacklist:#{token}", "true")
    REDIS_CLIENT.expire("blacklist:#{token}", 60*60*12)
    token
  end
end
