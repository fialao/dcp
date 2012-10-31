require File.join(File.dirname(__FILE__), '../', 'spec_helper')

describe Dcp do

  describe "#identify_all" do
    subject { described_class.new('eth0') }

    context "with mock of PacketFu::Capture" do
      let(:capture) { double('PacketFu::Capture').as_null_object }
      before(:each) { PacketFu::Capture.stub('new').and_return(capture) }

      it "should call #send with IdentifyAllRequest" do
        subject.should_receive('send').with(described_class::IdentifyAllRequest.to_b)
        subject.identify_all(0)
      end
    end

    it "should call #capture with proper timeout" do
      timeout = 5
      subject.should_receive('capture').with(timeout).and_return([])
      subject.identify_all(timeout)
    end

    it "should process received frames and return result" do
      subject.stub('capture').and_return([1,2,3])
      Dcp::IdentifyResponse.should_receive('parse').twice.and_return('ok')
      Dcp::IdentifyResponse.should_receive('parse').and_return(nil)
      devices = subject.identify_all
      devices.size.should == 2
    end

  end

end