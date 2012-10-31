require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp do

  describe "::SetIpRequest constant hash" do
    it "should have correct byte representation" do
      described_class::SetIpRequest.to_b.should == "\xFE\xFD\x04\x00\x01\x00\x00\x01\x00\x00\x00\x12\x01\x02\x00\x0e\x00\x01\xc0\xa8\x00\x01\xff\xff\xff\x00\x00\x00\x00\x00"
    end
  end

  describe "::SetResponse structure" do
    let(:mac_address) { 'a1:b2:c3:d4:e5:f6' }
    let(:success)     { true }
    subject           { described_class::SetResponse.new(mac_address, success) }

    describe "attributes" do
      it "should return mac address" do
        subject.mac_address.should == mac_address
      end

      it "should return success" do
        subject.success.should == success
      end
    end

    describe ".parse" do
      it "should return proper success object with" do
        frame = "
          \x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xfd
          \x04\x01\x01\x00\x00\x01\x00\x00\x00\x08\x05\x04\x00\x03\x01\x02
          \x00\x00".gsub!(/\n\ |\ /, '')
        o = described_class::SetResponse.parse(frame)
        o.success.should be_true
      end

      it "should return proper failed object with" do
        frame = frame = "
          \x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xfd
          \x04\x01\x01\x00\x00\x01\x00\x00\x00\x08\x05\x04\x00\x03\x01\x02
          \x03\x00".gsub!(/\n\ |\ /, '')
        o = described_class::SetResponse.parse(frame)
        o.success.should be_false
      end

      it "should return nil, if gets incorrect frame" do
        frame = "\x00\x0c\x29\xba\x09\xea\xa1\xb2\xc3\xd4\xe5\xf6\x88\x92\xfe\xfe"
        described_class::SetResponse.parse(frame).should be_nil
      end
    end
  end

end