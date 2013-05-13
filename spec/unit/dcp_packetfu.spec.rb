require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  context "private" do
    describe "#interface_mac_address" do
      let(:ifconfig_result) { double(Hash).as_null_object }

      it "calls PacketFu::Utils.ifconfig with proper argument" do
        subject.interface = 'en0'
        PacketFu::Utils.should_receive(:ifconfig).with('en0').and_return ifconfig_result
        subject.instance_eval { interface_mac_address }
      end
    end

    describe "#send" do
      let(:packet)  { double('PacketFu::Packet').as_null_object }
      before(:each) {
        PacketFu::Packet.stub('new').and_return(packet)
        PacketFu::Utils.stub('ifconfig').and_return({})
      }

      it "sets desired mac address" do
        destination_mac = 'a1:b2:c3:d4:e5:f6'
        packet.should_receive('eth_daddr=').with(destination_mac)
        subject.instance_eval { send destination_mac, '' }
      end

      it "sets desired payload" do
        payload = '\x00\x00\x00\x00'
        packet.should_receive('payload=').with(payload)
        subject.instance_eval { send '', payload }
      end

      it "sends packet" do
        packet.should_receive('to_w')
        subject.instance_eval { send '', '' }
      end
    end

    describe "#capture" do
      let(:capture) { double('PacketFu::Capture').as_null_object }
      before(:each) {
        PacketFu::Capture.stub('new').and_return(capture)
        subject.stub('sleep')
      }

      it "starts capturing packets from correct interface" do
        subject.interface = 'en0'
        PacketFu::Capture.should_receive('new').with(hash_including iface: 'en0', start: true).and_return(capture)
        subject.instance_eval { capture {} }
      end

      it "waits desired timeout for identify responses" do
        subject.timeout = 5
        subject.should_receive('sleep').with(5)
        subject.instance_eval { capture {} }
      end

      it "saves and return response frames" do
        response = 'ok'
        capture.should_receive('save')
        capture.should_receive('array').and_return(response)
        subject.instance_eval { capture {} }.should == response
      end
    end

    describe "#responses_to" do
      before { subject.stub(:capture).and_return({}) }

      it "capture resposes to request" do
        request = mock(Dcp::Frames::Common).as_null_object
        subject.should_receive(:capture).and_return({})
        subject.instance_eval { responses_to 'a1:b2:c3:d4:e5:f6', request }
      end

      it "randomize request xid" do
        request = Dcp::Frames::SetRequest.new
        xid     = request.xid
        subject.instance_eval { responses_to 'a1:b2:c3:d4:e5:f6', request }
        request.xid.should_not == xid
      end
    end

    describe "#result_of" do
      before { subject.stub(:responses_to).and_return({}) }
      it "calls responses_to with proper arguments" do
        request = mock(Dcp::Frames::Common).as_null_object
        subject.should_receive(:responses_to).with('a1:b2:c3:d4:e5:f6', request).and_return({})
        subject.instance_eval { result_of 'a1:b2:c3:d4:e5:f6', request }
      end

      it "returns nil if no response is received" do
        request = mock(Dcp::Frames::Common).as_null_object
        subject.instance_eval { result_of 'a1:b2:c3:d4:e5:f6', request }.should be_nil
      end
    end
  end
end
