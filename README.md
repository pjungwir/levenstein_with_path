levenstein_with_path
====================

[![Build Status](https://travis-ci.org/pjungwir/levenstein_with_path.svg?branch=master)](https://travis-ci.org/pjungwir/levenstein_with_path)

Ruby gem to find the Levenstein distance *and its sequence of edits*
between two strings or arrays of tokens (like words, lines, etc.).

Based on the [Wagner-Fischer algorithm](https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm),
which is `O(n^2)` but lets you retain the history of edits.


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'levenstein_with_path'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install levenstein_with_path


Usage
-----

```ruby
p = LevensteinWithPath::Path.new('kitten', 'sitting')
p.score
# => 3
p.edits
# => [
#   LevensteinWithPath::Swap.new('k', 's'),
#   LevensteinWithPath::Keep.new('i'),
#   LevensteinWithPath::Keep.new('t'),
#   LevensteinWithPath::Keep.new('t'),
#   LevensteinWithPath::Swap.new('e', 'i'),
#   LevensteinWithPath::Keep.new('n'),
#   LevensteinWithPath::Insert.new('g'),
# ]
```


Tests
-----

Say `rake` to run rspec tests plus Rubocop,
or `rspec spec` to run just the tests.


Contributing
------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone hasn't already requested and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make be sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, that is fine, but please isolate that change to its own commit so I can cherry-pick around it.

Commands for building/releasing/installing:

* `rake build`
* `rake install`
* `rake release`

Copyright
---------

Copyright (c) 2018 Paul A. Jungwirth.
See LICENSE.txt for further details.
