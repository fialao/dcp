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

end