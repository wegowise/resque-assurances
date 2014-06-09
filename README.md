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

## Contributing

Find a mistake? Submit a pull request!
