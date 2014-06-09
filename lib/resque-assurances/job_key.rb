module Resque
  module Assurances
    class JobKey
      def initialize(worker, *args)
        @shash = generate_key(worker, *args)
      end

      def to_s
        @shash
      end

      private

      def generate_key(*args)
        Digest::MD5.hexdigest(Resque.encode(args))
      end
    end
  end
end
