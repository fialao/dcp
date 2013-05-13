require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  describe "#initialize" do
    it "sets interface attribute" do
      described_class.new('en1').interface.should == 'en1'
    end

    it "sets timeout attribute" do
      described_class.new('en1', 4).timeout.should == 4
    end
  end
end
