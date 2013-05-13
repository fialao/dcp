require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::Common do
  subject { described_class.new(:device, :name) }

  describe ".create_from" do
    let(:data) { "\x02\x02\x00\x01\x00\x00".b }

    it "creates instance of proper class" do
      described_class.create_from(data).should be_instance_of(Dcp::Blocks::DeviceName)
    end

    it "calls parse with proper content" do
      Dcp::Blocks::DeviceName.any_instance.should_receive(:parse).with("\x00".b)
      described_class.create_from(data)
    end

    it "slice data" do
      described_class.create_from(data)
      data.should be_empty
    end

    it "returns nil for unknown option" do
      described_class.create_from("\x00\x00\x00\x01\x00\x00".b).should be_nil
    end

    it "returns nil for unknown suboption" do
      described_class.create_from("\xFF\x00\x00\x01\x00\x00".b).should be_nil
    end
  end

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :device
      subject.suboption.should  == :name
    end
  end

  describe "#to_b" do
    it "returns block content as byte string" do
      subject.stub(:content).and_return "\x00\x00".b
      subject.to_b.should == "\x02\x02\x00\x02\x00\x00".b
    end

    it "adds padding if content length is odd" do
      subject.stub(:content).and_return "\x00".b
      subject.to_b.should == "\x02\x02\x00\x01\x00\x00".b
    end
  end

  describe "#parse" do
    let(:data)  { "\x00\x00".b }
    before      { subject.parse(data) }

    it "sets proper BlockInfo" do
      subject.block_info.should == 0x0000
    end

    it "slice data" do
      data.length.should == 0
    end
  end
end
