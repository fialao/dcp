require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Frames::SetResponse do
  subject { described_class.new }

  describe "#initialize" do
    it "sets proper frame serviceId and serviceType" do
      subject.service.should  == :set
      subject.type.should     == :response
    end
  end

end
