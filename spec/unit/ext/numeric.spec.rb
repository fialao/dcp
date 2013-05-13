require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Numeric do

  describe "#to_ip" do
    it "returns string in ip address format" do
      3232235521.to_ip.should == '192.168.0.1'
      4294967040.to_ip.should == '255.255.255.0'
      0.to_ip.should          == '0.0.0.0'
    end
  end

  describe "#to_byte" do
    it "returns string formatted as Unsigned8" do
      0x00.to_byte.should == "\x00".b
      0x9A.to_byte.should == "\x9A".b
      0xFF.to_byte.should == "\xFF".b
    end
  end

  describe "#to_word" do
    it "returns string formatted as Unsigned16" do
      0x0000.to_word.should == "\x00\x00".b
      0x89AB.to_word.should == "\x89\xAB".b
      0xFFFF.to_word.should == "\xFF\xFF".b
    end
  end

  describe "#to_double" do
    it "returns string formatted as Unsigned32" do
      0x00000000.to_double.should == "\x00\x00\x00\x00".b
      0x6789ABCD.to_double.should == "\x67\x89\xAB\xCD".b
      0xFFFFFFFF.to_double.should == "\xFF\xFF\xFF\xFF".b
    end
  end

end
