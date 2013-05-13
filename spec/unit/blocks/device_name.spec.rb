require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::DeviceName do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :device
      subject.suboption.should  == :name
    end

    it "sets name_of_station attribute" do
      described_class.new('device_name').name_of_station.should == 'device_name'
    end

    it "sets block_info attribute for temporary change" do
      described_class.new('device_name', :temporary).block_info.should == "\x00\x00".b
    end

    it "sets block_info attribute for permanent change" do
      described_class.new('device_name', :permanent).block_info.should == "\x00\x01".b
    end
  end

  describe "#content" do
    it "returns block_info and name_of_station" do
      described_class.new('device_name', :temporary).content.should == "\x00\x00device_name".b
    end
  end

  describe "#parse" do
    before { subject.parse "\x00\x00device_name".b }

    it "sets proper BlockInfo" do
      subject.block_info.should == 0x0000
    end

    it "sets proper name_of_station" do
      subject.name_of_station.should == 'device_name'
    end
  end

end
