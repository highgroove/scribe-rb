# For some reason, strict_read and strict_write need to be disabled to
# receive messages from Scribe. The basic Thrift library generated for
# Ruby does not appear to easily allow that.
module Thrift
  class NonStrictBinaryProtocolFactory < BinaryProtocolFactory
    def get_protocol(trans)
      return Thrift::BinaryProtocol.new(trans, false, false)
    end
  end
end
