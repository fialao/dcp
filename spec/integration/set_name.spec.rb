require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  describe "set device name" do
    let(:device_mac)  { "01:ab:02:cd:03:ef" }
    let(:request)     { "\xfe\xfd\x04\x00\x01\x00\x00\x01\x00\x01\x00\x0c\x02\x02\x00\x08\x00\x01device".b }
    let(:response)    { "\xde\x30\xdc\x20\xba\x10\x01\xab\x02\xcd\x03\xef\x88\x92\xfe\xfd\x04\x01\x01\x00\x00\x01\x00\x00\x00\x08\x05\x04\x00\x03\x02\x02\x00\x00".b }

    before(:each) {
      PacketFu::Capture.stub(:new).and_return mock(PacketFu::Capture).as_null_object
      subject.stub(:rand).and_return(0x01000001)
      subject.stub('sleep')
    }

    it "sends proper request" do
      subject.should_receive(:send).with(device_mac, request)
      subject.set_name(device_mac, 'device')
    end

    it "returns 'ok' if response is ok" do
      subject.stub(:capture).and_return([response])
      subject.set_name(device_mac, 'device').should == 'ok'
    end

  end
end
