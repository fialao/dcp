require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Frames::IdentifyRequest do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper frame serviceId and serviceType" do
      subject.service.should  == :identify
      subject.type.should     == :request
    end
  end

  describe "#all" do
    it "add AllSelector block" do
      subject.all
      subject.blocks.last.should be_instance_of(Dcp::Blocks::AllAll)
    end

    it "returns self" do
      subject.all.should == subject
    end
  end

end
