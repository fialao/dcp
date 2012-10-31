require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  subject { described_class.new('eth0') }

  describe "#identify_all" do
    context "with mock of PacketFu::Capture" do
      let(:capture) { double('PacketFu::Capture').as_null_object }
      before(:each) { PacketFu::Capture.stub('new').and_return(capture) }

      it "should call #send with Profinet multicast mac address and IdentifyAllRequest" do
        subject.should_receive('send').with(described_class::IDENTIFY_MULTICAST_MAC, described_class::IdentifyAllRequest.to_b)
        subject.identify_all(0)
      end
    end

    it "should call #capture with proper timeout" do
      timeout = 5
      subject.should_receive('capture').with(timeout).and_return([])
      subject.identify_all(timeout)
    end

    it "should process received frames and return result" do
      subject.stub('capture').and_return([1,2,3])
      Dcp::IdentifyResponse.should_receive('parse').twice.and_return('ok')
      Dcp::IdentifyResponse.should_receive('parse').and_return(nil)
      devices = subject.identify_all
      devices.size.should == 2
    end
  end

  describe "#identify" do
    let(:device_mac)  { 'a1:b2:c3:d4:e5:f6' }

    context "with mock of PacketFu::Capture" do
      let(:capture)     { double('PacketFu::Capture').as_null_object }
      before(:each)     { PacketFu::Capture.stub('new').and_return(capture) }

      it "should call #send with device mac address and IdentifyAllRequest" do
        subject.should_receive('send').with(device_mac, described_class::IdentifyAllRequest.to_b)
        subject.identify(device_mac, 0)
      end
    end

    it "should call #capture with proper timeout" do
      timeout = 5
      subject.should_receive('capture').with(timeout).and_return([])
      subject.identify(device_mac, timeout)
    end

    it "should process received frames and return device info" do
      subject.stub('capture').and_return([1,2,3])
      Dcp::IdentifyResponse.should_receive('parse').twice.and_return(nil)
      Dcp::IdentifyResponse.should_receive('parse').and_return(Dcp::IdentifyResponse.new('', device_mac, '', '', ''))
      device = subject.identify(device_mac)
      device.should_not be_nil
    end
  end

end