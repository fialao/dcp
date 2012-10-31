require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Numeric do

  describe "#ones_complement" do
    it "should return proper 1's complement for 4bits number" do
      0b0000.ones_complement(4).should == 0b1111
      0b0101.ones_complement(4).should == 0b1010
      0b1111.ones_complement(4).should == 0
    end

    it "should return proper 1's complement for 32bits number" do
      0x00000000.ones_complement(32).should == 0xffffffff
      0x0f0f0f0f.ones_complement(32).should == 0xf0f0f0f0
      0xffffffff.ones_complement(32).should == 0
    end

    it "should return 1's complement for part of the number if bits is smaller then bits count" do
      0b0000.ones_complement(2).should == 0b0011
      0b1101.ones_complement(2).should == 0b1110
      0b1111.ones_complement(2).should == 0b1100
    end

    it "should return proper 1's complement if bits is greater then bits count" do
      0b0000.ones_complement(8).should == 0b11111111
      0b1101.ones_complement(8).should == 0b11110010
      0b1111.ones_complement(8).should == 0b11110000
    end
  end

end