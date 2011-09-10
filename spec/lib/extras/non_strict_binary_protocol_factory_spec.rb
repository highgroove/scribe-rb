require "spec_helper"

describe Thrift::NonStrictBinaryProtocolFactory do
  subject { described_class.new }

  describe "#get_protocol" do
    it "constructs a BinaryProtocol instance with strict_read and strict_write as false" do
      Thrift::BinaryProtocol.should_receive(:new).
                             with(anything, false, false)

      subject.get_protocol(double)
    end
  end
end
