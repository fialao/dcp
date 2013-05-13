require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::AllAll do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :all
      subject.suboption.should  == :all
    end
  end

  describe "#content" do
    it "returns empty string" do
      subject.content.should == ''
    end
  end

end
