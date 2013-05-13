require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::ControlFactoryReset do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :control
      subject.suboption.should  == :factory_reset
    end
  end

  describe "#content" do
    it "returns default BlockQualifier" do
      subject.content.should == "\x00\x00".b
    end
  end

end
