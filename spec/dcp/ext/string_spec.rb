require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe String do

  describe "#to_mac" do
    it "should return string formatted as readeable mac address" do
      "\xa1\xb2\xc3\xd4\xe5\xf6".to_mac.should == 'a1:b2:c3:d4:e5:f6'
    end
  end

  describe "#to_ip" do
    it "should return string formatted as readeable ip address" do
      "\xc0\xa8\x00\x01".to_ip.should == '192.168.0.1'
    end
  end

  describe "#to_b" do
    it "should return string in ip address format as byte string" do
      '192.168.0.1'.to_b.should   == "\xc0\xa8\x00\x01"
      '255.255.255.0'.to_b.should == "\xff\xff\xff\x00"
      '0.0.0.0'.to_b.should       == "\x00\x00\x00\x00"
    end
  end

end