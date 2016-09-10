# Extensible

[![Gem Version](http://img.shields.io/gem/v/extensible.svg)][gem]
[![Build Status](http://img.shields.io/travis/gdeoliveira/extensible/master.svg)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/gdeoliveira/extensible.svg)][codeclimate]
[![Test Coverage](http://img.shields.io/codeclimate/coverage/github/gdeoliveira/extensible.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/gdeoliveira/extensible.svg?branch=master)][inch-ci]

[gem]: https://rubygems.org/gems/extensible
[travis]: http://travis-ci.org/gdeoliveira/extensible/branches
[codeclimate]: https://codeclimate.com/github/gdeoliveira/extensible
[inch-ci]: http://inch-ci.org/github/gdeoliveira/extensible

Use Extensible on your custom extensions in order to get the following set of advantages over traditional extensions
that override the `Module#extended` method directly:

- Calls to `super` are handled internally to ensure all your _extensible_ extensions are properly initialized.
- Your _extensible_ extensions will be automatically able to become the base of other, more specific extensions while
proper initialization is maintained by simply including them.
- Bundle several _extensible_ extensions in a single module by including them and they will all be correctly initialized
when extending the bundler module.

Specific examples for each of these scenarios can be found in the [usage](#usage) section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "extensible"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extensible

## When should I use Extensible?

You should use Extensible every time you're implementing a module that is intended to be used as an extension for a
module or a class **and** that extension needs to have some initialization code.

In short: if you are going to override `Module#extended`, use Extensible instead.

<a name="usage"></a>
## Usage

#### Basic

Creating an _extensible_ extension module is, arguably, simpler than creating a traditional extension that overrides
`Module#extended`. Note that we do not need to call `super` within the code block since it will be called "under the
hood" _before_ the code is executed:

```ruby
module MyExtension
  extend Extensible
  when_extended {|m| puts "#{self} has extended #{m}." }
end
```

As you would expect, this is what happens when you use your _extensible_ extension in a class (or module):

```ruby
class MyClass
  extend MyExtension
end  #=> MyExtension has extended MyClass.
```

#### Extending extensions

The extensions you create using Extensible are "extensible" in the sense that you (or someone else) can use them as the
base for other, more specific extensions. The best bit is you get this at no additional cost. Simply include them and
extend away!

Suppose we have a base extension that sets an instance variable that holds the reversed name of the module or class
extending it:

```ruby
module MyBaseExtension
  extend Extensible
  when_extended do |m|
    m.instance_variable_set(:@reversed_name, m.to_s.reverse)
  end
end
```

Now we can use `MyBaseExtension` on its own, but we can also _extend_ it to, for example, create a reader method for the
`@reversed_name` variable by including it on our more specific `MySubExtension`:

```ruby
module MySubExtension
  include MyBaseExtension
  attr_reader :reversed_name
end
```

We can now extend `MySubExtension` ensuring that the initialization routine of `MyBaseExtension` is executed as
expected:

```ruby
class MyClass
  extend MySubExtension
end

MyClass.reversed_name  #=> "ssalCyM"
```

Note: `MySubExtension` could have (if needed) extended Extensible to provide its own initialization routine. In this
case both initialization routines (the one for `MyBaseExtension` and the one for `MySubExtension`) would have been
executed when `MyClass` extended it.

#### Bundling extensions

Traditional extensions that override the `Module#extended` method work correctly as long as they are explicitly extended
in the module or class that will ultimately use them. This can become really cumbersome really fast when you want to
apply several extensions to a set of different modules or classes.

Using _extensible_ extensions you can bundle many of them within a single module, and then extend all of them at the
same time by extending the bundler module.

Suppose you have two extensions (`A` and `B`) that you want to bundle together:

```ruby
module A
  extend Extensible
  when_extended { puts "A was extended!" }
end

module B
  extend Extensible
  when_extended { puts "B was extended!" }
end
```

Simply include them in your bundler module:

```ruby
module Bundle
  include A
  include B
end
```

And extend it!

```ruby
module MyClass
  extend Bundle
end  #=> A was extended!
     #=> B was extended!
```

## Contributing

1. Fork it ( https://github.com/gdeoliveira/extensible/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
