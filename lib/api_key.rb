module APIKey
  module ClassMethods
    attr_accessor :api_key
  end

  def self.included( klass )
    klass.extend ClassMethods
  end

  attr_writer :api_key

  def api_key
    @api_key || self.class.api_key
  end
end
