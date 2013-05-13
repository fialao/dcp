require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Frames::SetRequest do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper frame serviceId and serviceType" do
      subject.service.should  == :set
      subject.type.should     == :request
    end
  end

  describe "#name" do
    it "add NameOfStation block" do
      subject.name('device_name', :permanent)
      subject.blocks.last.should be_instance_of(Dcp::Blocks::DeviceName)
    end

    it "sets proper arguments for NameOfStation block contructor" do
      Dcp::Blocks::DeviceName.should_receive(:new).with('device_name', :permanent)
      subject.name('device_name', :permanent)
    end

    it "returns self" do
      subject.name('device_name', :permanent).should == subject
    end
  end

  describe "#ip" do
    it "add IpParameters block" do
      subject.ip('192.168.0.11', '255.255.255.0', '192.168.0.1', :permanent)
      subject.blocks.last.should be_instance_of(Dcp::Blocks::IpIp)
    end

    it "sets proper arguments for NameOfStation block contructor" do
      Dcp::Blocks::IpIp.should_receive(:new).with('192.168.0.11', '255.255.255.0', '192.168.0.1', :permanent)
      subject.ip('192.168.0.11', '255.255.255.0', '192.168.0.1', :permanent)
    end

    it "returns self" do
      subject.ip('192.168.0.11', '255.255.255.0', '192.168.0.1', :permanent).should == subject
    end
  end

  describe "#signal" do
    it "add ControlSignal block" do
      subject.signal
      subject.blocks.last.should be_instance_of(Dcp::Blocks::ControlSignal)
    end

    it "returns self" do
      subject.signal.should == subject
    end
  end

  describe "#factory_reset" do
    it "add ControlFactoryReset block" do
      subject.factory_reset
      subject.blocks.last.should be_instance_of(Dcp::Blocks::ControlFactoryReset)
    end

    it "returns self" do
      subject.factory_reset.should == subject
    end
  end

end
