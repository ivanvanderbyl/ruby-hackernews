module RubyHackernews
  module MechanizeContext
    @@contexts = {}

    def self.agent=(key)
      @@default = key
    end

    def agent
      @@default ||= :default
      @@contexts[@@default] = Mechanize.new unless @@contexts[@@default]
      @@contexts[@@default].user_agent = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

      return @@contexts[@@default]
    end

    def [](key)
      return @@contexts[key]
    end

    def require_authentication
      raise NotAuthenticatedError unless authenticated?
    end

    def authenticated?(key = :default)
      return @@contexts[key] && @@contexts[key].cookie_jar.jar.any?
    end
  end
end
