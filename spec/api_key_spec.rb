require 'spec_helper'

class DummyClass
  include APIKey
end

describe APIKey do
  before( :all ) { @DEFAULT_KEY = "a default key".freeze }
  let( :apiKeyClass ) { DummyClass.dup }

  it "sets the default (class) key to nil" do
    apiKeyClass.api_key.should be_nil
  end

  describe '.api_key=' do
    it "allows a default key to be set" do
      apiKeyClass.api_key = @DEFAULT_KEY
      apiKeyClass.instance_eval{ @api_key }.should == @DEFAULT_KEY
    end
  end

  describe ".api_key" do
    it "retains only the last default key set" do
      [ @DEFAULT_KEY, 'another key', 'new key set' ].each do |key|
        apiKeyClass.api_key = key
      end

      apiKeyClass.api_key.should == "new key set"
    end
  end

  let( :uses_api_key ) { apiKeyClass.new }

  describe '#api_key_param_name' do
    it "returns nil by default" do
      uses_api_key.api_key_param_name.should be_nil
    end

    context "after the class calls .api_key_param_name" do
      it "returns a symbol of the provided argument" do
        [
          ["a_string_key", :a_string_key],
          [:a_symbol_key,  :a_symbol_key],
        ].each do |param_name, param_name_as_sym|
          apiKeyClass.class_eval{ api_key_param_name param_name }
          uses_api_key.api_key_param_name.should == param_name_as_sym
        end
      end
    end
  end

  describe "#api_key=" do
    it "sets the instance key" do
      uses_api_key.api_key = @INSTANCE_KEY
      uses_api_key.instance_eval{ @api_key }.should == @INSTANCE_KEY
    end
  end

  describe "#api_key" do
    context "given no instance key set" do
      context "when no default (class) key set" do
        it "returns nil" do
          uses_api_key.api_key.should be_nil
        end
      end

      context "when default (class) key set" do
        it "returns the last default (class) key set" do
          [ @DEFAULT_KEY, 'another key', 'new key set' ].each do |key|
            apiKeyClass.api_key = key
          end

          uses_api_key.api_key.should == 'new key set'
        end
      end
    end

    context "given instance key set" do
      before( :all  ) { @INSTANCE_KEY = "an instance key".freeze }
      before( :each ) { uses_api_key.api_key = @INSTANCE_KEY     }

      context "when no default (class) key set" do
        it "returns instance key" do
          uses_api_key.class.instance_eval{ @api_key }.should be_nil
          uses_api_key.api_key.should == @INSTANCE_KEY
        end
      end

      context "when default (class) key set" do
        it "returns instance key" do
          apiKeyClass.api_key = @DEFAULT_KEY
          uses_api_key.api_key.should == @INSTANCE_KEY
        end
      end
    end
  end
end
