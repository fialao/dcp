require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe String do

  describe "#camelize" do
    it "capitalize first letter" do
      'a'.camelize.should     == 'A'
      'test'.camelize.should  == 'Test'
    end

    it "converts underscore_format to UpperCamelCase" do
      'one_underscore'.camelize.should        == 'OneUnderscore'
      'with_two_underscores'.camelize.should  == 'WithTwoUnderscores'
    end

    it "doesn't modify empty string" do
      ''.camelize.should == ''
    end
  end

  describe "#to_mac" do
    it "returns string formatted as readeable mac address" do
      "\x00\x00\x00\x00\x00\x00".b.to_mac.should == '00:00:00:00:00:00'
      "\xa1\xb2\xc3\xd4\xe5\xf6".b.to_mac.should == 'a1:b2:c3:d4:e5:f6'
      "\xff\xff\xff\xff\xff\xff".b.to_mac.should == 'ff:ff:ff:ff:ff:ff'
    end
  end

  describe "#to_ip" do
    it "returns string formatted as readeable ip address" do
      "\x00\x00\x00\x00".b.to_ip.should == '0.0.0.0'
      "\xc0\xa8\x00\x01".b.to_ip.should == '192.168.0.1'
      "\xff\xff\xff\xff".b.to_ip.should == '255.255.255.255'
    end
  end

  describe "#to_b" do
    it "returns string in ip address format as byte string" do
      '0.0.0.0'.to_b.should         == "\x00\x00\x00\x00".b
      '192.168.0.1'.to_b.should     == "\xc0\xa8\x00\x01".b
      '255.255.255.255'.to_b.should == "\xff\xff\xff\xff".b
    end
  end

  describe "#to_byte" do
    it "returns number formatted as Unsigned8" do
      "\x00".b.to_byte.should == 0x00
      "\x9A".b.to_byte.should == 0x9A
      "\xFF".b.to_byte.should == 0xFF
    end
  end

  describe "#to_word" do
    it "returns number formatted as Unsigned16" do
      "\x00\x00".b.to_word.should == 0x0000
      "\x89\xAB".b.to_word.should == 0x89AB
      "\xFF\xFF".b.to_word.should == 0xFFFF
    end
  end

  describe "#to_double" do
    it "returns number formatted as Unsigned32" do
      "\x00\x00\x00\x00".b.to_double.should == 0x00000000
      "\x67\x89\xAB\xCD".b.to_double.should == 0x6789ABCD
      "\xFF\xFF\xFF\xFF".b.to_double.should == 0xFFFFFFFF
    end
  end

end
