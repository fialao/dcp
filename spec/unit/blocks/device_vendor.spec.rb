require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::DeviceVendor do
  subject { described_class.new }

  it_has_readable_attribute :type_of_station

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :device
      subject.suboption.should  == :vendor
    end
  end

  describe "#parse" do
    before { subject.parse "\x00\x00device_type".b }

    it "sets proper BlockInfo" do
      subject.block_info.should == 0x0000
    end

    it "sets proper type_of_station" do
      subject.type_of_station.should == 'device_type'
    end
  end

end
