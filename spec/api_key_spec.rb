require 'spec_helper'

class DummyClass
  include APIKey
end

describe APIKey do
  before( :all ) { @DEFAULT_KEY = "a default key".freeze }

  let( :apiKeyClass ) { DummyClass.dup }

  context "for the Class" do
    it "sets the default key to nil" do
      apiKeyClass.api_key.should be_nil
    end

    describe "#api_key" do
      it "allows a default key to be set" do
        apiKeyClass.api_key = @DEFAULT_KEY
        apiKeyClass.api_key.should == @DEFAULT_KEY
      end

      it "retains only the last default key set" do
        apiKeyClass.api_key = @DEFAULT_KEY
        apiKeyClass.api_key.should == @DEFAULT_KEY
        apiKeyClass.api_key = "new key set"
        apiKeyClass.api_key.should == "new key set"
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
          apiKeyClass.api_key = @DEFAULT_KEY
          uses_api_key.api_key.should == @DEFAULT_KEY
        end
      end

      context "instance key set" do
        before( :all  ) { @INSTANCE_KEY = "an instance key".freeze }
        before( :each ) { uses_api_key.api_key = @INSTANCE_KEY     }

        it "returns the instance key when no default key set" do
          uses_api_key.api_key.should == @INSTANCE_KEY
        end

        it "returns the instance key when default key set" do
          apiKeyClass.api_key = @DEFAULT_KEY
          uses_api_key.api_key.should == @INSTANCE_KEY
        end
      end
    end
  end
end
