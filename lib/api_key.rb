# Provides general support for web/REST classes working with API keys.
#
# Many different web APIs require the use of a key to interact with the
# service. Some 3rd party Ruby APIs have implemented their own specific
# solution. Some set the key on the Class, others allow for each instance
# to set the key. This module provides mix-in support for a generalizd
# signature for working with these types of APIs.
#
# Author::    Aaron Kromer (https://github.com/cupakromer)
# Copyright:: Copyright (c) 2012
# License::   Distributes under the same terms as Ruby

# Mix-in module for providing support to work with API keys.
#
# Example
#
#   class XyzService
#     include APIKey
#
#     api_key_param_name :service_key
#   end
module APIKey
  module ClassMethods
    # Sets the default key
    attr_accessor :api_key

    private

    # Define instance method returning the parameter name to use for
    # the API Key in the options hash.
    #
    #
    # Will symbolize the provided name parameter when defining the method.
    #
    # name - The String or Symbol name to set the API Key hash key to
    #
    #
    # Examples
    #
    #   class XyzService
    #     include APIKey
    #
    #     api_key_param_name :service_key
    #     # => def api_key_param_name
    #     #      :service_key
    #     #    end
    #   end
    #
    #
    #   class XyzService
    #     include APIKey
    #
    #     api_key_param_name "string_service_key"
    #     # => def api_key_param_name
    #     #      :string_service_key
    #     #    end
    #   end
    #
    #
    # Returns nothing
    def api_key_param_name( name )
      define_method( :api_key_param_name ) { name.to_sym }
    end
  end

  # Automatically extend ClassMethods when including module
  def self.included( klass )
    klass.extend ClassMethods
  end

  # Set the API Key for this specific instance object
  attr_writer :api_key

  # Return the set API Key.
  #
  # If an API Key has been set on this object instance, then that is used.
  # Otherwise the default (class) key will be used.
  #
  #
  # Examples
  #
  #
  #   class XyzService
  #     include APIKey
  #   end
  #
  #   service = XyzService.new
  #
  #
  #   service.api_key
  #   # => nil
  #
  #
  #   XyzService.api_key = "a default key"
  #   service.api_key
  #   # => "a default key"
  #
  #
  #   service.api_key = "an instance key"
  #   service.api_key
  #   # => "an instance key"
  #
  #
  # Returns the API Key if set, otherwise nil.
  def api_key
    # We are not lazy loading the @api_key in order to preserve the
    # distinction between it and the default (class) key.
    @api_key || self.class.api_key
  end

  # Return the set API key parameter options hash key.
  #
  # Returns the symbolized version set API Key parameter options hash key,
  #   or nil if nothing was set.
  def api_key_param_name
    nil
  end

  # Return an options hash with the API Key.
  #
  # Uses the set API Key parameter name symbol as the key and the result
  # of calling #api_key as the value.
  #
  #
  # Example
  #
  #
  #   class XyzService
  #     include APIKey
  #
  #     api_key_param_name :service_key
  #   end
  #
  #   service = XyzService.new
  #   service.api_key = "my special key"
  #
  #   service.api_key_option
  #   # => { service_key: "my special key" }
  #
  #
  # Returns the options hash with the API Key.
  # Raises RuntimeError: "No API Key parameter name set" if
  #   Class.api_key_param_name did not set a key value
  def api_key_option
    fail "No API Key parameter name set" unless api_key_param_name
    { api_key_param_name => api_key }
  end
end
