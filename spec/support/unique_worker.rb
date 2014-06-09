class UniqueWorker < TestWorker
  extend Resque::Assurances::Uniqueness
end
