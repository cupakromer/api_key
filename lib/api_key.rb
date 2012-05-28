# Provides general support for web/REST classes working with API keys.
#
# Many different web API require the use of an API to interact with the
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

  def self.included( klass )
    klass.extend ClassMethods
  end

  attr_writer :api_key

  def api_key
    # We are not lazy loading the @api_key in order to preserve the
    # distinction between it and the default (class) key.
    @api_key || self.class.api_key
  end

  def api_key_param_name
    nil
  end

  def api_key_option
    fail "No API Key parameter name set" unless api_key_param_name
    { api_key_param_name => api_key }
  end
end
