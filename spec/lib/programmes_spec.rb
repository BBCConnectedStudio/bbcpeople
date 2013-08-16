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
        Programmes.episode?('b00t18c6').should == false
      end
    end
  end
end
