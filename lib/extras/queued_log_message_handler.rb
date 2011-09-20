require "thread"

module FacebookService
  class QueuedLogMessageHandler < BaseHandler
    attr_reader :queue

    def initialize(name)
      super(name)

      @queue = Queue.new
    end

    def Log(messages)
      messages.each do |message|
        @queue.push(message)
      end

      ::ResultCode::OK
    rescue Exception => e
      ::ResultCode::TRY_LATER
    end
  end
end
