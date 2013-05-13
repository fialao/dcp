require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Blocks::ControlResponse do
  subject { described_class.new }

  it_has_readable_attribute :response_option
  it_has_readable_attribute :response_suboption
  it_has_readable_attribute :response_error

  describe "#initialize" do
    it "sets proper block option and suboption" do
      subject.option.should     == :control
      subject.suboption.should  == :response
    end
  end

  describe "#parse" do
    context "for set ip parameters response" do
      before { subject.parse "\x01\x02\x00".b }

      it "sets proper response option and suboption" do
        subject.response_option.should    == :ip
        subject.response_suboption.should == :ip
      end

      it "indicates valid operation" do
        subject.response_error.should == :ok
      end
    end

    context "for set device name response" do
      before { subject.parse "\x02\x02\x00".b }

      it "sets proper response option and suboption" do
        subject.response_option.should    == :device
        subject.response_suboption.should == :name
      end

      it "indicates valid operation" do
        subject.response_error.should == :ok
      end
    end

    context "for invalid operation" do
      it "indicates error" do
        subject.parse("\x02\x02\x01".b)
        subject.response_error.should_not == :ok
      end
    end
  end

end
