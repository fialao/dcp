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

      it "should send packet with desired payload" do
        payload = 'payload'
        packet.should_receive('payload=').with(payload)
        packet.should_receive('to_w')
        subject.instance_eval { send payload }
      end
    end

  end

end