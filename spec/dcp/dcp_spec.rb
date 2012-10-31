require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  let(:interface) { 'eth0' }
  subject         { described_class.new(interface) }

  describe "attributes" do
    it "should return interface" do
      subject.interface.should == interface
    end
  end

  describe "#initialize" do
    it "should set interface attribute" do
      o = described_class.new(interface)
      o.interface.should == interface
    end
  end

  context "private" do

    describe "#capture" do
      let(:capture) { double('PacketFu::Capture').as_null_object }
      before(:each) { PacketFu::Capture.stub('new').and_return(capture) }

      it "should start capturing packets from correct interface" do
        PacketFu::Capture.should_receive('new').with(hash_including iface: interface, start: true).and_return(capture)
        subject.instance_eval { capture(0) {} }
      end

      it "should wait desired timeout for identify responses" do
        timeout = 5
        subject.should_receive('sleep').with(timeout)
        subject.instance_eval { capture(5) {} }
      end

      it "should save and return response frames" do
        response = 'ok'
        capture.should_receive('save')
        capture.should_receive('array').and_return(response)
        subject.instance_eval { capture(0) {} }.should == response
      end
    end

    describe "#send" do
      let(:packet)  { double('PacketFu::Packet').as_null_object }
      before(:each) {
        PacketFu::Packet.stub('new').and_return(packet)
        PacketFu::Utils.stub('ifconfig').and_return({})
      }

      it "should set desired mac address" do
        destination_mac = 'a1:b2:c3:d4:e5:f6'
        packet.should_receive('eth_daddr=').with(destination_mac)
        subject.instance_eval { send destination_mac, '' }
      end

      it "should set desired payload" do
        payload = '\x00\x00\x00\x00'
        packet.should_receive('payload=').with(payload)
        subject.instance_eval { send '', payload }
      end

      it "should send packet" do
        packet.should_receive('to_w')
        subject.instance_eval { send '', '' }
      end
    end

  end

end