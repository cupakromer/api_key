module APIKey
  module ClassMethods
    attr_accessor :api_key

    private

    def api_key_param_name( name )
      define_method( :api_key_param_name ) { name.to_sym }
    end
  end

  def self.included( klass )
    klass.extend ClassMethods
  end

  attr_writer :api_key

  def api_key
    @api_key || self.class.api_key
  end

  def api_key_param_name
    nil
  end

  def api_key_param
    { api_key_param_name => api_key }
  end
end
