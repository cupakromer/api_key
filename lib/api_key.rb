module APIKey
  module ClassMethods
    attr_accessor :default_api_key
  end

  def self.included( klass )
    klass.extend ClassMethods
  end

  @default_api_key = nil

  attr_writer :api_key

  def api_key
    @api_key || self.class.default_api_key
  end
end
