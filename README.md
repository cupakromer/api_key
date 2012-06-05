API Key
=======

[![Build Status](https://secure.travis-ci.org/cupakromer/api_key.png?branch=master)](http://travis-ci.org/cupakromer/api_key)

Ruby mix-in providing general support for using API keys with web
interfaces.

Many different web APIs require the use of a key to interact with the
service. Some 3rd party Ruby APIs have implemented their own specific
solution. Some set the key on the Class, others allow for each instance
to set the key. This module provides mix-in support for a generalizd
signature for working with these types of APIs.


Installing
----------

Get the latest version (you will need rake or just run `bundle` after
cloning):

```bash
git clone git://github.com/cupakromer/api_key.git
cd api_key
rake install
```

When using [Bundler](http://gembundler.com "Bundler Home"):

```ruby
gem "api_key", :git => "git://github.com/cupakromer/api_key.git"
```


Using
-----

Just mix-in the module:

```ruby
require 'api_key'

class XyzService
  include APIKey
end
```

### Class level (default) keys

```ruby
# Set a default key for the class
XyzService.api_key = "really_ugly_long_hex_string"
XyzService.api_key
# => "really_ugly_long_hex_string"

service = XyzService.new
service.api_key
# => "really_ugly_long_hex_string"
```


### Using instance keys

```ruby
# Set a default key for the class
XyzService.api_key = "really_ugly_long_hex_string"
XyzService.api_key
# => "really_ugly_long_hex_string"

service_A = XyzService.new
service_B = XyzService.new

# Set a key for this instance
service_A.api_key = "foo_s_ugly_long_hex_key"
service_A.api_key
# => "foo_s_ugly_long_hex_key"

service_B.api_key
# => "really_ugly_long_hex_string"
```


### Getting the parameter option hash

```ruby
class XyzService
  include APIKey

  # Failure to set the param name will result in a RuntimeError when
  # #api_key_option is called
  api_key_param_name :service_key
end

service = XyzService.new
service.api_key_option
# => { service_key: nil }

XyzService.api_key = "really_ugly_long_hex_string"
service.api_key_option
# => { service_key: "really_ugly_long_hex_string" }
```



Bugs, Issues, and Suggestions
-----------------------------

Please submit them here https://github.com/cupakromer/api_key/issues


Contributing
------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it.
* Commit, but please do not mess with rakefile, version, or history.
* Send me a pull request.


Copyright / License
-------------------

Copyright (c) 2012 Aaron Kromer, released under the MIT License.

See [LICENSE][] for details.

[license]: https://github.com/cupakromer/api_key/blob/master/LICENSE
