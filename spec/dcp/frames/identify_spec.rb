require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp do

  describe "::IdentifyAllRequest constant hash" do
    it "should have correct byte representation" do
      described_class::IdentifyAllRequest.to_b.should == "\xFE\xFE\x05\x00\x01\x00\x00\x01\x00\x01\x00\x04\xFF\xFF\x00\x00"
    end
  end

  describe "::IdentifyResponse structure" do
    let(:name)        { 'rack.device' }
    let(:mac_address) { 'a1:b2:c3:d4:e5:f6' }
    let(:ip_address)  { '192.168.0.1' }
    let(:subnet_mask) { 24 }
    let(:description) { 'TESTING-DEVICE' }
    subject           { described_class::IdentifyResponse.new(name, mac_address, ip_address, subnet_mask, description) }

    describe "attributes" do
      it "should return name" do
        subject.name.should == name
      end

      it "should return mac address" do
        subject.mac_address.should == mac_address
      end

      it "should return ip address" do
        subject.ip_address.should == ip_address
      end

      it "should return subnet mask" do
        subject.subnet_mask.should == subnet_mask
      end

      it "should return description" do
        subject.description.should == description
      end
    end

    describe ".parse" do
      it "should return proper object, if gets correct frame (from Wireshrak DCP example)" do
        frame = "
          \x00\x0c\x29\xba\x09\xea\x08\x00\x06\x93\xcf\x32\x88\x92\xfe\xff
          \x05\x01\x01\x00\x00\x01\x00\x00\x00\x5e\x02\x05\x00\x1c\x00\x00
          \x01\x01\x01\x02\x02\x01\x02\x02\x02\x03\x02\x04\x02\x05\x03\x3d
          \x05\x01\x05\x02\x05\x03\x05\x04\xff\xff\x02\x01\x00\x05\x00\x00
          \x49\x4e\x43\x00\x02\x02\x00\x0b\x00\x00\x58\x32\x30\x38\x2d\x42
          \x4f\x52\x44\x00\x02\x03\x00\x06\x00\x00\x00\x2a\x0a\x01\x02\x04
          \x00\x04\x00\x00\x01\x00\x01\x02\x00\x0e\x00\x01\xc0\xa8\x00\x06
          \xff\xff\xff\x00\xc0\xa8\x00\x01".gsub!(/\n\ |\ /, '')
        o = described_class::IdentifyResponse.parse(frame)
        o.name.should         == 'X208-BORD'
        o.mac_address.should  == '08:00:06:93:cf:32'
        o.ip_address.should   == '192.168.0.6'
        o.subnet_mask.should  == 24
        o.description.should  == 'INC'
      end

      it "should return proper object, if gets correct frame (with subject values)" do
        frame = "
          \x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xff
          \x05\x01\x01\x00\x00\x01\x00\x00\x00\x5e\x02\x05\x00\x1c\x00\x00
          \x01\x01\x01\x02\x02\x01\x02\x02\x02\x03\x02\x04\x02\x05\x03\x3d
          \x05\x01\x05\x02\x05\x03\x05\x04\xff\xff\x02\x01\x00\x10\x00\x00
          TESTING-DEVICE\x02\x02\x00\x0d\x00\x00rack.device\x00\x02\x03\x00
          \x06\x00\x00\x00\x2a\x0a\x01\x02\x04\x00\x04\x00\x00\x01\x00\x01
          \x02\x00\x0e\x00\x01\xc0\xa8\x00\x01\xff\xff\xff\x00\xc0\xa8\x00
          \x01".gsub!(/\n\ |\ /, '')
        o = described_class::IdentifyResponse.parse(frame)
        o.name.should         == name
        o.mac_address.should  == mac_address
        o.ip_address.should   == ip_address
        o.subnet_mask.should  == subnet_mask
        o.description.should  == description
      end

      it "should return nil, if gets incorrect frame" do
        frame = "\x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xfe"
        described_class::IdentifyResponse.parse(frame).should be_nil
      end
    end
  end

end