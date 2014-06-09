# resque-assurances

Provide specific assurances for resque jobs.

## Getting Started

If you're using Bundler, you can add resque-assurances to your Gemfile:

```ruby
gem 'resque-assurances'
```

Or manually install the resque-assurances gem:

```shell
gem install resque-assurances
```

## Usage

### Uniqueness

Generates an MD5 of the job's arguments and uses a redis set to record what
jobs have been queued. Jobs that have been performed will be removed from the
set so that they can be queued again.

```ruby
class MyWorker
  extend Resque::Assurances::Uniqueness

  @queue = :my_work
end

Resque.enqueue(MyWorker, 42)
Resque.enqueue(MyWorker, 42) # This will do nothing.
```

### Persistence

Keep a record outside of resque for worker arguments that need to be run. If
resque's queues are cleared, you can restore the same jobs.

This module does not persist jobs that have no payload.

```ruby
class MyWorker
  extend Resque::Assurances::Persistence

  @queue = :my_work
end

# You queue your job...
Resque.enqueue(MyWorker, 42)

# All of a sudden the queue disappears... mysteriously!
Resque::Job.destroy(MyWorker.queue, 'MyWorker')

# Don't worry. If you queue a new worker without args, your worker will perform
# the work with the previously-queued payload.
Resque.enqueue(MyWorker)
```

## Contributing

Find a mistake? Submit a pull request!
