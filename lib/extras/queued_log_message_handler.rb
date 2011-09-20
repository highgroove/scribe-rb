require "thread"

module FacebookService
  class QueuedLogMessageHandler < BaseHandler
    attr_reader   :queue

    # If message_limit is exceeded, the handler will not accept any more
    # messages from Scribe. The messages will be kept by Scribe and sent
    # later.
    attr_accessor :message_limit

    def initialize(name)
      super(name)

      @queue = Queue.new
    end

    def Log(messages)
      if self.message_limit.nil? || self.queue.size < self.message_limit
        messages.each do |message|
          self.queue.push(message)
        end

        ::ResultCode::OK
      else
        ::ResultCode::TRY_LATER
      end
    rescue Exception => e
      ::ResultCode::TRY_LATER
    end
  end
end
