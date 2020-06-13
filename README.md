# Sidekiq::Sequence - Sequential Sidekiq jobs.

Sidekiq is awesome, but it doesn't provide any support for sequential jobs, where a sequence of jobs must be run in a set order.

Sidekiq::Sequence provides a simple yet powerful framework to run a sequence of Sidekiq jobs, where each job runs only when the previous job successfully completes. It relies on Sidekiq's retry functionality to handle failed jobs. So if a job fails, any subsequent jobs will not run. Once the job is retried and is successful, the next job will start.

> **NOTE:** Sidekiq::Sequence is currently only intended for use in Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-sequence'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sidekiq-sequence

Run the Rails generator to install the database migration:

    $ rails g sidekiq_sequence:install
    $ rails db:migrate

## Usage

Start with a Sequence class which inherits from `Sidekiq::Sequence::Base`, and define each step of the sequence:

```ruby
class ContactFormSequence < Sidekiq::Sequence::Base
  step CreateMessage
  step AssignMessage
end
```

Each step should be a class that includes `Sidekiq::Sequence::Worker`, and behaves just like a regular Sidekiq Worker:

```ruby
class ContactFormSequence::CreateMessage
  include Sidekiq::Sequence::Worker

  def perform
    # Perform your job
  end
end
```

Each Step is run in the order they are defined, and each is a Sidekiq worker. If a worker fails, subsequent steps will not be run, and the worker will be placed in the Sidekiq retry queue. Once it succeeds, the next stepo will be run, and so on.

Start a Sequence by simply initializing the Sequence class you created:

```ruby
ContactFormSequence.new name: 'Joel', github: 'joelmoss'
```

You can pass named arguments, and these will be persisted and available in the Sequence and its workers:

```ruby
class ContactFormSequence::AssignMessage
  include Sidekiq::Sequence::Worker

  def perform
    @data # -> { name: 'Joel', github: 'joelmoss' }
  end
end
```

You can also modify Sequence `data` in any worker, which is great for passing data to subsequent steps:

```ruby
class ContactFormSequence::CreateMessage
  include Sidekiq::Sequence::Worker

  def perform
    @data[:message] = 'my message' # @data is now { name: 'Joel', github: 'joelmoss', message: 'my message' }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joelmoss/sidekiq-sequence. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joelmoss/sidekiq-sequence/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sidekiq::Sequence project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joelmoss/sidekiq-sequence/blob/master/CODE_OF_CONDUCT.md).
