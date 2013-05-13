require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  let(:device_mac)  { '01:02:03:04:05:06' }
  subject           { described_class.new }
  before            { subject.stub(:result_of) }

  describe "#signal" do
    it "calls result_of with proper arguments" do
      subject.should_receive(:result_of).with(device_mac, an_instance_of(Dcp::Frames::SetRequest))
      subject.signal device_mac
    end

    it "calls signal on set request frame" do
      Dcp::Frames::SetRequest.any_instance.should_receive(:signal).and_call_original
      subject.signal device_mac
    end
  end

  describe "#factory_reset" do
    it "calls result_of with proper arguments" do
      subject.should_receive(:result_of).with(device_mac, an_instance_of(Dcp::Frames::SetRequest))
      subject.factory_reset device_mac
    end

    it "calls factory_reset on set request frame" do
      Dcp::Frames::SetRequest.any_instance.should_receive(:factory_reset).and_call_original
      subject.factory_reset device_mac
    end
  end
end
