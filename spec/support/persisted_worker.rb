class PersistedWorker < TestWorker
  extend Resque::Assurances::Persistence
end
