API Key Support
===============

Provide both class and instance level support for handling API keys. This is to be used as a mix-in:

    class NeedAPIKey
      include APIKey
      api_key_query_parameter_name :super_secret_key
    end

Class Level
-----------

* This sets the "default" api key

To Do

    @default_api_key = nil
    @api_key_name = nil
    class << self
      attr_accessor :default_api_key

      # I don't think this is how you do this
      def api_key_query_parameter_name( name )
        @api_key_name = name
      end
    end


Instance Level
--------------

* Setting a key at an instance level trumps the class level

Example:

    attr_writer :api_key
    def api_key
      @api_key || self.class.default_api_key
    end

    # TODO: Wrap existing method if it exists?
    def as_query( options )
      { query: { self.class.api_key_name = api_key }.merge(options) }
    end

