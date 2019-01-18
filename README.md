# Techno Delivery

This project is not quite a Gem yet, however it can be run in the console by following the directions in Usage, below. This project gathers information about techno releases that are posted on Berlin record store Hard Wax's website. All new release information is scraped from the site using Open-uri and Nokogiri, sorted by subgenre and stored in a series of objects. The stored data is then accessed by a CLI program that can print new release information to the screen by subgenre or in total for the week and includes an option to play each track's sample (only on Macs) after the releases are printed.

## Installation

- not yet operational

## Usage

After launching the project by typing ./bin/techno_delivery, you will be prompted to choose a subgenre of techno for which you would like to see this week's releases for. You can also choose to view all of the week's releases. After making your choice, you will have the option of listening to samples of the tracks on each release. If you choose to do so, each track on each release will be played in order until all releases have been played. If you want to skip a track, press <enter>. If you want to exit the program at this point, a hard exit can be accomplished by pressing <ctrl-c>. After all tracks have been played, you will be given the option to explore other subgenres or exit.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anberns/flatiron-project1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Project1 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/project_1/blob/master/CODE_OF_CONDUCT.md).
