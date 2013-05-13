require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::ControlSignal do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :control
      subject.suboption.should  == :signal
    end
  end

  describe "#content" do
    it "returns default BlockQualifier and FLASH_ONCE" do
      subject.content.should == "\x00\x00\x01\x00".b
    end
  end

end
