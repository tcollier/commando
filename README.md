# Commando

Boxers? Briefs? Commando!

_A command line interface builder with Readline support_

## Versions

* `0.1.0` - Initial release
* `0.1.1` - Alphabetize commands printed via `help`
* `0.1.2` - Remove empty lines from history
* `0.2.0` - Persist history across CLI sessions
* `0.2.1` - Fix bug when history file doesn't exist
* `1.0.0` - Use `ArgumentError` instead of custom error for bad args
* `2.0.0` - Remove global config

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tcollier-commando'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tcollier-commando

## Configuration

You can configure the start up greeting, the command line prompt, and the set
of available commands to use. To do so, start Commando with the block syntax as
follows

```ruby
Commando.start do |config|
  # The greeting to print when the CLI is started
  config.greeting = 'Welcome to my CLI. Type "help" for a list of commands'

  # The prompt to print every time a new command is desired
  config.prompt = 'my-app> '

  # An optional file where command line history is stored across sessions
  config.history_file = '/tmp/.commando_history'

  # Register multiple commands
  config.register 'addfriend', MyApp::AddFriend.new, 'Adds a friend to your network'
  config.register 'listfriends', MyApp::ListFriends.new, 'List all friends in your network'
end
```

### Actions

To support a new command, you must register it with

* The command the user will type (e.g. `addfriend`).
* A class/module/instance that fills the `Action` role.
* A brief description of what the command does and what arguments it takes, if any.

#### Action role

The `Action` role responds to `perform(args:)`, where

* `args` [`Array<String>`] - the list of the extra words that follow the command
(e.g. if the user types `addfriend mary jane`, then the args are `['mary', 'jane']`).

If the arguments are not formatted correctly (e.g. the user missed an argument),
then method should raise an `ArgumentError` with a descriptive message.

#### Default actions

A few default actions have been registered

* `help` - Prints a help message, including a list of commands
* `history` - Prints the history of commands entered so far
* `quit` - Exits the program


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/commando. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
