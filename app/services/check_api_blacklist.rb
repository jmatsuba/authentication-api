class CheckApiBlacklist
  include Interactor

  def call
    context.blacklisted = check_blacklist(context.token)
  end

  private

  def check_blacklist(token)
    !!REDIS_CLIENT.get("blacklist:#{token}")
  end
end
