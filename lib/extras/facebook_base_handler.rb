module FacebookService
  class BaseHandler
    def initialize(name)
      @name           = name
      @alive          = Time.now.to_i

      @counters       = Hash.new { |h, k| h[k] = 0 }
      @counters_mutex = Mutex.new

      @options        = Hash.new
      @options_mutex  = Mutex.new
    end

    def getName
      @name
    end

    def getVersion
      ""
    end

    def getStatus
      Fb_status::ALIVE
    end

    def getStatusDetails
      ""
    end

    def getCounters
      @counters_mutex.synchronize do
        @counters
      end
    end

    def getCounter(key)
      @counters_mutex.synchronize do
        @counters[key]
      end
    end

    def setOption(key, value)
      @options_mutex.synchronize do
        @options[key] = value
      end
    end

    def getOption(key)
      @options_mutex.synchronize do
        @options[key]
      end
    end

    def getOptions
      @options_mutex.synchronize do
        @options
      end
    end

    def getCpuProfile(*)
      ""
    end

    def aliveSince
      @alive
    end

    def reinitialize
    end

    def shutdown
    end
  end
end
