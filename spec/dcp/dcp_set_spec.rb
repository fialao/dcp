require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do

  describe "#set_ip" do
    let(:device_mac)  { 'a1:b2:c3:d4:e5:f6' }
    let(:ip_address)  { '192.168.0.1' }
    let(:subnet_mask) { 24 }
    let(:gateway)     { '0.0.0.0' }
    context "with mock of PacketFu::Capture" do
      let(:capture)     { double('PacketFu::Capture').as_null_object }
      before(:each)     { PacketFu::Capture.stub('new').and_return(capture) }

      it "should call #send with device mac address and SetIpRequest" do
        subject.should_receive('send').with(device_mac, described_class::SetIpRequest.to_b)
        subject.set_ip(device_mac, ip_address, subnet_mask, gateway, 0)
      end
    end

    it "should call #capture with proper timeout" do
      timeout = 5
      subject.should_receive('capture').with(timeout).and_return([])
      subject.set_ip(device_mac, ip_address, subnet_mask, gateway, timeout)
    end

    context "process received frames" do
      it "return true, if succeeds" do
        subject.stub('capture').and_return(['ok'])
        Dcp::SetResponse.should_receive('parse').and_return(Dcp::SetResponse.new(device_mac, true))
        subject.set_ip(device_mac, ip_address, subnet_mask, gateway).should be_true
      end

      it "return false, if fails" do
        subject.stub('capture').and_return(['ok'])
        Dcp::SetResponse.should_receive('parse').and_return(Dcp::SetResponse.new(device_mac, false))
        subject.set_ip(device_mac, ip_address, subnet_mask, gateway).should be_false
      end

      it "return false, if device not exists" do
        subject.stub('capture').and_return([])
        subject.set_ip(device_mac, ip_address, subnet_mask, gateway).should be_false
      end
    end
  end
end