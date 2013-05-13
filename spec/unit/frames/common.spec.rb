require File.join(File.dirname(__FILE__), '../../', 'spec_helper')

describe Dcp::Frames::Common do
  subject { described_class.new(:set, :request) }

  describe ".create_from" do
    let(:ethernet_header) { "\x01\x02\x03\x04\x05\x06\x01\x02\x03\x04\x05\x06\x88\x92".b }
    let(:frame_id)        { "\xFE\xFD".b }
    let(:frame_content)   { "\x04\x01\x01\x00\x00\x01\x00\x01\x00\x04\x01\x02\x03\x04".b }
    let(:data)            { "#{ethernet_header}#{frame_id}#{frame_content}" }
    before                { described_class.any_instance.stub :parse }
    it "creates instance of proper class" do
      described_class.create_from(data).should be_instance_of(Dcp::Frames::SetResponse)
    end

    it "calls parse with proper content" do
      described_class.any_instance.should_receive(:parse).with(frame_content)
      described_class.create_from(data)
    end

    it "returns nil for unknown frame" do
      described_class.create_from("#{ethernet_header}#{frame_id}"+"\x00\x00".b).should be_nil
    end
  end

  describe "#initialize" do
    it "sets proper frame serviceId and serviceType" do
      subject.service.should  == :set
      subject.type.should     == :request
    end

    it "sets xid attribute" do
      subject = described_class.new(:set, :request, 0x12345678)
      subject.xid.should == 0x12345678
    end

    it "sets xid attribute to default if it's not provided" do
      subject = described_class.new(:set, :request)
      subject.xid.should == 0x01000001
    end

    it "initialize blocks attribute" do
      subject.blocks.should be_empty
    end
  end

  describe "#block" do
    let(:block)   { Dcp::Blocks::DeviceVendor.new }
    let(:blocks)  { [Dcp::Blocks::AllAll.new, Dcp::Blocks::DeviceRole.new, block, Dcp::Blocks::ControlSignal.new] }
    before        { subject.blocks = blocks }

    it "finds proper block" do
      subject.block(:device, :vendor).should == block
    end

    it "returns nil if block doesn't exist" do
      subject.block(:ip, :ip).should be_nil
    end
  end

  describe "#to_b" do
    it "returns frame content as byte string" do
      subject.to_b.should == "\xFE\xFD\x04\x00\x01\x00\x00\x01\x00\x01\x00\x00".b
    end

    context "with blocks" do
      let(:blocks)  { Array.new }
      before        { subject.blocks = blocks }

      it "appends blocks content" do
        blocks.should_receive(:map).and_return ["\x01\x02".b, "\x03\x04".b]
        subject.to_b.should == "\xFE\xFD\x04\x00\x01\x00\x00\x01\x00\x01\x00\x04\x01\x02\x03\x04".b
      end
    end
  end

  describe "#parse" do
    let(:data)  { "\x04\x01\x12\x34\x56\x78\x00\x01\x00\x00".b }

    it "sets proper service ID" do
      subject.parse(data)
      subject.service.should == :set
    end

    it "sets proper service type" do
      subject.parse(data)
      subject.type.should == :success_response
    end

    it "sets proper xid" do
      subject.parse(data)
      subject.xid.should == 0x12345678
    end

    it "calls Dcp::Blocks::Common.create_from with proper argument" do
      Dcp::Blocks::Common.should_receive(:create_from).with("\x02\x02\x00\x00".b).and_call_original
      subject.parse("\x04\x01\x12\x34\x56\x78\x00\x01\x00\x04\x02\x02\x00\x00".b)
    end
  end

  context "private" do
    describe "#frame_id" do
      it "returns proper frameId for hello service" do
        subject.service = :hello
        subject.send(:frame_id).should == "\xFE\xFC".b
      end

      it "returns proper frameId for identify service" do
        subject.service = :identify
        subject.send(:frame_id).should == "\xFE\xFE".b
      end

      it "returns proper frameId for get or set service" do
        subject.service = :get
        subject.send(:frame_id).should == "\xFE\xFD".b
        subject.service = :set
        subject.send(:frame_id).should == "\xFE\xFD".b
      end
    end
  end

end
