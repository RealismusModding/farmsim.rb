# FarmSim tooling

master: [![Build Status](https://travis-ci.org/RealismusModding/farmsim.rb.svg?branch=master)](https://travis-ci.org/RealismusModding/farmsim.rb)
develop: [![Build Status](https://travis-ci.org/RealismusModding/farmsim.rb.svg?branch=develop)](https://travis-ci.org/RealismusModding/farmsim.rb)

This is the FarmSim tooling gem, excellent for developing script mods for Farming Simulator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'farmsim'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install farmsim

## Usage

To start a new mod, run:
```sh
fs init myMod
cd myMod
```
This will create a new folder 'myMod' with a modDesc, src/loader.lua, farmsim.yml and base translation file.

You can configure the builds using the `config` command, for example, setting debug flag on:
```sh
fs config templates.debug=true
```

Build the mod in current directory and install it in the Farming Simulator mods folder (assuming you configured your `~/.fsbuild.yml`):
```sh
fs install
```

Run Farming Simulator:
```sh
fs run
```

Run a specific savegame:
```sh
fs run -s 5
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/farmsim. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Farmsim project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/farmsim/blob/master/CODE_OF_CONDUCT.md).
