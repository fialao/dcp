require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::DeviceRole do
  subject { described_class.new }

  it_has_readable_attribute :roles

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :device
      subject.suboption.should  == :role
    end

    it "initialize roles attribute" do
      subject.roles.should be_empty
    end
  end

  describe "#parse" do
    it "sets proper BlockInfo" do
      subject.parse "\x00\x00\x00".b
      subject.block_info.should == 0x0000
    end

    it "sets device role" do
      subject.parse "\x00\x00\x01".b
      subject.roles.should == [:device]
    end

    it "sets supervisor role" do
      subject.parse "\x00\x00\x08".b
      subject.roles.should == [:supervisor]
    end

    it "sets multiple roles" do
      subject.parse "\x00\x00\x06".b
      subject.roles.should include(:controller, :multidevice)
      subject.roles.should_not include(:device, :supervisor)
    end
  end

end
