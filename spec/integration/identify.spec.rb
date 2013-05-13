require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  describe "identify all connected devices" do
    let(:request) { "\xfe\xfe\x05\x00\x01\x00\x00\x01\x00\x01\x00\x04\xff\xff\x00\x00".b }

    let(:correct_response) { "
      \x00\x0c\x29\xba\x09\xea\x08\x00\x06\x93\xcf\x32\x88\x92\xfe\xff
      \x05\x01\x01\x00\x00\x01\x00\x00\x00\x5e\x02\x05\x00\x1c\x00\x00
      \x01\x01\x01\x02\x02\x01\x02\x02\x02\x03\x02\x04\x02\x05\x03\x3d
      \x05\x01\x05\x02\x05\x03\x05\x04\xff\xff\x02\x01\x00\x05\x00\x00
      \x49\x4e\x43\x00\x02\x02\x00\x0b\x00\x00\x58\x32\x30\x38\x2d\x42
      \x4f\x52\x44\x00\x02\x03\x00\x06\x00\x00\x00\x2a\x0a\x01\x02\x04
      \x00\x04\x00\x00\x01\x00\x01\x02\x00\x0e\x00\x01\xc0\xa8\x00\x06
      \xff\xff\xff\x00\xc0\xa8\x00\x01".b.gsub!(/\n\ |\ /, '') }

    let(:incorrect_response) { "\x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xfe" }

    before(:each) {
      PacketFu::Capture.stub(:new).and_return mock(PacketFu::Capture).as_null_object
      subject.stub(:rand).and_return(0x01000001)
      subject.stub('sleep')
    }

    it "sends proper request" do
      subject.should_receive(:send).with('01:0e:cf:00:00:00', request)
      subject.identify_all
    end

    it "returns proper responses, if gets correct frame" do
      subject.stub(:capture).and_return([correct_response])
      response = subject.identify_all

      # mac
      response.keys.first.should == '08:00:06:93:cf:32'

      # header
      header = response.values.first
      header.should be_instance_of Dcp::Frames::IdentifyResponse
      header.service.should == :identify
      header.type.should    == :success_response

      # device/vendor
      block = response.values.first.block(:device, :vendor)
      block.type_of_station.should == 'INC'

      # device/name
      block = response.values.first.block(:device, :name)
      block.name_of_station.should == 'X208-BORD'

      # device/role
      block = response.values.first.block(:device, :role)
      block.roles.should == [:device]

      # ip/ip
      block = response.values.first.block(:ip, :ip)
      block.ip_address.should       == '192.168.0.6'
      block.subnet_mask.should      == '255.255.255.0'
      block.standard_gateway.should == '192.168.0.1'
    end

    it "raises error, if gets incorrect frame" do
      subject.stub(:capture).and_return([incorrect_response])
      expect { subject.identify_all }.to raise_error
    end
  end
end
