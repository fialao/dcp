require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Frames::IdentifyResponse do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper frame serviceId and serviceType" do
      subject.service.should  == :identify
      subject.type.should     == :response
    end
  end

end
