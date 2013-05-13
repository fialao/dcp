require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  let(:device_mac)  { '01:02:03:04:05:06' }
  subject           { described_class.new }
  before            { subject.stub(:result_of) }

  describe "#set_name" do
    it "calls result_of with proper arguments" do
      subject.should_receive(:result_of).with(device_mac, an_instance_of(Dcp::Frames::SetRequest))
      subject.set_name device_mac, 'device_name'
    end

    it "calls set_name on set request frame" do
      Dcp::Frames::SetRequest.any_instance.should_receive(:name).with('device_name', :temporary).and_call_original
      subject.set_name device_mac, 'device_name', :temporary
    end
  end

  describe "#set_ip" do
    it "calls result_of with proper arguments" do
      subject.should_receive(:result_of).with(device_mac, an_instance_of(Dcp::Frames::SetRequest))
      subject.set_ip device_mac, '192.168.0.1'
    end

    it "calls set_ip on set request frame" do
      Dcp::Frames::SetRequest.any_instance.should_receive(:ip).with('192.168.0.11', '255.255.255.0', '192.168.0.1', :temporary).and_call_original
      subject.set_ip device_mac, '192.168.0.11', '255.255.255.0', '192.168.0.1', :temporary
    end
  end
end
