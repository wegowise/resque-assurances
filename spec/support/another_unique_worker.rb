class AnotherUniqueWorker < TestWorker
  extend Resque::Assurances::Uniqueness
end
