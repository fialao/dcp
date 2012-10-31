require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Hash do

  describe "#to_b" do
    it "should return empty string for empty hash" do
      {}.to_b.should == ''
    end

    it "should return values as string" do
      {a: 'a', b: 'b', c: 'c'}.to_b.should == 'abc'
      {a: 'a', b: '', c: 'c'}.to_b.should  == 'ac'
      {a: "\x01", b: "\x02", c: "\x03"}.to_b.should == "\x01\x02\x03"
    end
  end

end