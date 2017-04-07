# Commando

A command line interface builder with Readline support

## Versions

* `0.1.0` - Initial release
* `0.1.1` - Alphabetize commands printed via `help`
* `0.1.2` - Remove empty lines from history

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'commando'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install commando

## Configuration

You can configure the start up greeting, the command line prompt, and the set
of available commands to use.

```ruby
Commando.configure do |config|
  config.greeting = 'Welcome to my CLI. Type "help" for a list of commands'
  config.prompt = 'my-app> '

  config.register 'addfriend', MyApp::AddFriend, 'Adds a friend to your network'
end
```

### Actions

To support a new command, you must register it with

* The command the user will type (e.g. `addfriend`).
* A class/module/instance that fills the `Action` role.
* A brief description of what the command does and what arguments it takes, if any.

#### Action role

The `Action role` responds to `perform(args, output:)`, where

* `args` [`Array<String>`] - the list of the extra words that follow the command
(e.g. if the user types `addfriend mary jane`, then the args are `['mary', 'jane']`).
* `output` [`IO`] - the IO instance that any messages should be written to.

If the arguments are not formatted correctly (e.g. the user missed an argument),
then method should raise a `Commando::ValidationError` with a descriptive message.

#### Default actions

A few default actions have been registered

* help - Prints a help message, including a list of commands
* history - Prints the history of commands entered so far
* quit - Exits the program

## Usage

Once commando is configured, simply run `Commando.start` to enter the command
line interface.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/commando. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
