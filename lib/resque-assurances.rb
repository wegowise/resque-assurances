require 'resque'
require_relative 'resque-assurances/uniqueness'
require_relative 'resque-assurances/job_key'

module Resque
  module Assurances
    REDIS_UNIQUENESS_KEY = 'resque:assurances:uniqueness'

    class << self
      def reset!
        redis.del(REDIS_UNIQUENESS_KEY)
      end

      def unique?(key)
        !redis.sismember(REDIS_UNIQUENESS_KEY, key)
      end

      def set_key(key)
        redis.sadd(REDIS_UNIQUENESS_KEY, key)
      end

      def remove_key(key)
        redis.srem(REDIS_UNIQUENESS_KEY, key)
      end

      def redis
        Resque.redis
      end
    end
  end
end
