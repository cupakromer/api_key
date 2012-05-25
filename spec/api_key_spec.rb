require 'spec_helper'

class APIKey
  @default_api_key = nil
  class << self
    attr_accessor :default_api_key
  end
end

describe APIKey do
  let( :apiKeyClass ) { APIKey }

  context "for the Class" do
    it "sets the default key to nil" do
      apiKeyClass.default_api_key.should be_nil
    end

    describe "#default_api_key" do
      it "allows a default key to be set" do
        apiKeyClass.default_api_key = "a default key"
        apiKeyClass.default_api_key.should == "a default key"
      end

      it "retains only the last default key set" do
        apiKeyClass.default_api_key = "a default key"
        apiKeyClass.default_api_key.should == "a default key"
        apiKeyClass.default_api_key = "new key set"
        apiKeyClass.default_api_key.should == "new key set"
      end
    end
  end

  context "as an instance" do
    describe "#api_key" do
      it "returns the class default key"
    end
  end
end
