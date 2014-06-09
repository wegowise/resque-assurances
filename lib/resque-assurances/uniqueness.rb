module Resque
  module Assurances
    module Uniqueness
      def enqueue_once(*args)
        key = Resque::Assurances::JobKey.new(self, args)

        if Resque::Assurances.unique?(key)
          Resque.enqueue(self, *args)
          Resque::Assurances.set_key(key)
        end
      end

      def perform(*args)
        key = Resque::Assurances::JobKey.new(self, args)
        super(*args)
      ensure
        Resque::Assurances.remove_key(key)
      end
    end
  end
end
