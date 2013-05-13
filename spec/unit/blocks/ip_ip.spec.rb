require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::IpIp do
  subject { described_class.new('192.168.0.11', '255.255.255.0', '192.168.0.1') }

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :ip
      subject.suboption.should  == :ip
    end

    it "sets ip_address attribute" do
      subject.ip_address.should == '192.168.0.11'
    end

    it "sets subnet_mask attribute" do
      subject.subnet_mask.should == '255.255.255.0'
    end

    it "sets standard_gateway attribute" do
      subject.standard_gateway.should == '192.168.0.1'
    end

    it "sets block_info attribute for temporary change" do
      described_class.new('192.168.0.11', '255.255.255.0', '192.168.0.1', :temporary).block_info.should == "\x00\x00".b
    end

    it "sets block_info attribute for permanent change" do
      described_class.new('192.168.0.11', '255.255.255.0', '192.168.0.1', :permanent).block_info.should == "\x00\x01".b
    end
  end

  describe "#content" do
    it "returns block_info and ip parameters" do
      subject.content.should == "\x00\x00\xC0\xA8\x00\x0B\xFF\xFF\xFF\x00\xC0\xA8\x00\x01".b
    end
  end

  describe "#parse" do
    before { subject.parse "\x00\x00\xC0\xA8\x01\x0B\xFF\xFF\x00\x00\xC0\xA8\x01\x01".b }

    it "sets proper BlockInfo" do
      subject.block_info.should == 0x0000
    end

    it "sets proper ip_address" do
      subject.ip_address.should == '192.168.1.11'
    end

    it "sets proper subnet_mask" do
      subject.subnet_mask.should == '255.255.0.0'
    end

    it "sets proper standard_gateway" do
      subject.standard_gateway.should == '192.168.1.1'
    end
  end

end
