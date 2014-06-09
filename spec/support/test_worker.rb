class TestWorker
  class << self
    def queue
      '1'
    end

    def perform(*args)
      do_some_work(*args)
    end

    def do_some_work(*_args)
      # all done!
    end
  end
end
