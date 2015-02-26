# Samsara
[![Build Status](https://secure.travis-ci.org/tcnijmeijer/samsara.png?branch=master)](http://travis-ci.org/tcnijmeijer/samsara)
[![Code Climate](https://codeclimate.com/github/tcnijmeijer/samsara/badges/gpa.svg)](https://codeclimate.com/github/tcnijmeijer/samsara)
[![Test Coverage](https://codeclimate.com/github/tcnijmeijer/samsara/badges/coverage.svg)](https://codeclimate.com/github/tcnijmeijer/samsara)

A simple auditing gem that does things a little differently. Rather than just storing the domain changes made
this gem is also capable of storing the context in which the changes were made such as a http request. This
context is stored in a separate database table and is shared by multiple revisions in case a single request
causes changes to multiple domain models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'samsara'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install samsara

## Contributing

1. Fork it ( https://github.com/[my-github-username]/samsara/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
