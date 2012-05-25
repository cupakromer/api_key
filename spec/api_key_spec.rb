require 'spec_helper'

class APIKey
  @default_api_key = nil
  class << self
    attr_accessor :default_api_key
  end
end

describe APIKey do
  it "sets the default key to nil" do
    UsingAPIKey = APIKey
    UsingAPIKey.default_api_key.should be_nil
  end

  it "allows a default key to be set" do
    UsingAPIKey = APIKey
    UsingAPIKey.default_api_key = "a default key"
    UsingAPIKey.default_api_key.should == "a default key"
  end

  it "retains only the last key set" do
    UsingAPIKey = APIKey
    UsingAPIKey.default_api_key = "a default key"
    UsingAPIKey.default_api_key.should == "a default key"
    UsingAPIKey.default_api_key = "new key set"
    UsingAPIKey.default_api_key.should == "new key set"
  end
end
