require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe IpAddress do
  let(:ip_address)   { '192.168.0.1' }
  let(:subnet_mask)  { 24 }
  subject            { described_class.new(ip_address, subnet_mask) }

  describe "attributes" do
    it "should return address" do
      subject.address.should == ip_address
    end

    it "should return subnet mask" do
      subject.subnet_mask.should == subnet_mask
    end
  end

  describe "#initialize" do
    it "should create proper object, if gets ip address and subnet mask together" do
      o = described_class.new("#{ip_address}/#{subnet_mask}")
      o.address.should     == ip_address
      o.subnet_mask.should == subnet_mask
    end

    it "should create proper object, if gets ip address and subnet mask separately" do
      o = described_class.new(ip_address, subnet_mask)
      o.address.should     == ip_address
      o.subnet_mask.should == subnet_mask
    end
  end

  describe ".from_interface" do
    let(:interface) { 'eth0' }
    let(:ifconfig)  { "inet #{ip_address} netmask 0xffffff00"}

    it "should call ifconfig with interface name" do
      described_class.should_receive(:'`').with("ifconfig #{interface}").and_return(ifconfig)
      described_class.from_interface(interface)
    end

    it "should return proper object from interface settings" do
      described_class.should_receive(:'`').with("ifconfig #{interface}").and_return(ifconfig)
      o = described_class.from_interface(interface)
      o.address.should     == ip_address
      o.subnet_mask.should == subnet_mask
    end
  end

  describe "#to_s" do
    it "should return ip address and subnet mask separated with slash as String" do
      subject.to_s.should == "#{ip_address}/#{subnet_mask}"
    end
  end

  describe "#to_i" do
    it "should return ip address as FixNumber" do
      subject.to_i.should                                   == 3232235521
      described_class.new('127.0.0.1/32').to_i.should       == 2130706433
      described_class.new('255.255.255.255/32').to_i.should == 4294967295
    end
  end

  describe "#to_range" do
    it "should return ip address family range" do
      subject.to_range.should                                 == (3232235521..3232235774)   # 192.168.0.1..192.168.0.254
      described_class.new('192.168.0.1/16').to_range.should   == (3232235521..3232301054)   # 192.168.0.1..192.168.255.254
      described_class.new('192.168.0.100/28').to_range.should == (3232235617..3232235630)   # 192.168.0.97..192.168.0.110
    end
  end

  describe "#access?" do
    it "should return true, if ip address is accessible" do
      subject.access?(described_class.new('192.168.0.100/16')).should be_true
      subject.access?(described_class.new('192.168.0.100/31')).should be_true
    end

    it "should return false, if ip address is inaccessible" do
      subject.access?(described_class.new('192.168.100.100/16')).should be_false
      subject.access?(described_class.new('192.168.100.100/31')).should be_false
    end
  end

  describe "#===" do
    it "should return true, if ip address and itself is mutually accessible" do
      (subject === described_class.new('192.168.0.100/16')).should be_true
      (subject === described_class.new('192.168.0.100/24')).should be_true
    end

    it "should return false, if ip address and itself is mutually inaccessible" do
      (subject === described_class.new('192.168.0.100/31')).should be_false
      (subject === described_class.new('192.168.100.100/16')).should be_false
      (subject === described_class.new('192.168.100.100/31')).should be_false
    end
  end

end