# Elastip

Get your AWS elastic beanstalk active instances private IP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastip

## Usage

```
$> elastip project_name production
10.0.15.12
$> elastip 'pr*ject\d+' staging
10.0.15.42
```

You got the idea. You can then use it directly in an alias doing `ssh ec2-user@$(elastip project-name production)`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pcboy/elastip. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the WTFPL license (Do what the fuck you want to public license)
