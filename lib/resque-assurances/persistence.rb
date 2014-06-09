module Resque
  module Assurances
    module Persistence
      def persisted_key
        "resque:assurances:persistence:#{name}:#{queue}"
      end

      def destroy_queue!
        Resque.redis.del(persisted_key)
      end

      def before_enqueue_persisted_payload(*args)
        persisted_push(args) unless args.empty?
      end

      def around_perform_persisted_payload(*args)
        yield *persisted_pop if job_exists?
      end

      def persisted_push(payload)
        Resque.redis.rpush(persisted_key, encode(payload))
      end

      def persisted_pop
        decode(Resque.redis.lpop(persisted_key))
      end

      def job_exists?
        Resque.redis.llen(persisted_key) > 0
      end

      def encode(payload)
        Resque.encode(payload)
      end

      def decode(payload)
        Resque.decode(payload)
      end
    end
  end
end
