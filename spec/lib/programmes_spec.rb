require "spec_helper"

describe Programmes do

  describe ".episode" do

    describe "with episode pid" do
      it "returns true" do
        Programmes.episode?('b038rwc8').should == true
      end
    end

    describe "with movie pid" do
      it "returns false" do
        Programmes.episode?('b00t18c6').should == true
      end
    end
  end

  describe '.get_tagged_resources_for_pid' do
    describe 'with tagged episode' do
      it "returns an array of dbpedia keys" do
        Programmes.get_tagged_resources_for_pid('b0385gqh').should == ['BBC_Singers', 'BBC_Symphony_Chorus', 'BBC_Symphony_Orchestra']
      end
    end

    describe 'with an untagged episode' do
      it "returns an empty array" do
        Programmes.get_tagged_resources_for_pid('b038rwc8').should == []
      end
    end
  end
end
