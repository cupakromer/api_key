module APIKey
  attr_writer :api_key
  def api_key
    @api_key || self.class.default_api_key
  end
end
