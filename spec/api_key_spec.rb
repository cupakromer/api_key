require 'spec_helper'

class DummyClass
  include APIKey
end

describe APIKey do
  let( :apiKeyClass ) { DummyClass.dup }

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
    let( :uses_api_key ) { apiKeyClass.new }

    describe "#api_key" do
      context "no instance key set" do
        it "returns nil when no default key set" do
          uses_api_key.api_key.should be_nil
        end

        it "returns the default key" do
          apiKeyClass.default_api_key = "a default key"
          uses_api_key.api_key.should == "a default key"
        end
      end

      context "instance key set" do
        before( :each ) { uses_api_key.api_key = "an instance key" }

        it "returns the instance key when no default key set" do
          uses_api_key.api_key.should == "an instance key"
        end

        it "returns the instance key when default key set" do
          apiKeyClass.default_api_key = "a default key"
          uses_api_key.api_key.should == "an instance key"
        end
      end
    end
  end
end
