require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do
  let(:device_mac)  { '01:02:03:04:05:06' }
  subject           { described_class.new }
  before            { subject.stub(:responses_to) }

  describe "#identify_all" do
    it "calls responses_to with proper arguments" do
      subject.should_receive(:responses_to).with('01:0e:cf:00:00:00', an_instance_of(Dcp::Frames::IdentifyRequest))
      subject.identify_all
    end

    it "calls all on identify request frame" do
      Dcp::Frames::IdentifyRequest.any_instance.should_receive(:all).and_call_original
      subject.identify_all
    end
  end

  describe "#identify" do
    it "calls responses_to with proper arguments" do
      subject.should_receive(:responses_to).with(device_mac, an_instance_of(Dcp::Frames::IdentifyRequest))
      subject.identify device_mac
    end

    it "calls all on identify request frame" do
      Dcp::Frames::IdentifyRequest.any_instance.should_receive(:all).and_call_original
      subject.identify device_mac
    end
  end
end
