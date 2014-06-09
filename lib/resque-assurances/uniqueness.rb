module Resque
  module Assurances
    module Uniqueness
      def before_enqueue_save_job_key(*args)
        key = Resque::Assurances::JobKey.new(self, args)

        if Resque::Assurances.unique?(key)
          Resque::Assurances.set_key(key)
          true
        else
          false
        end
      end

      def around_perform_remove_job_key(*args)
        key = Resque::Assurances::JobKey.new(self, args)
        yield *args
      ensure
        Resque::Assurances.remove_key(key)
      end
    end
  end
end
