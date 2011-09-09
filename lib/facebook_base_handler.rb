module FacebookService
  # TODO: Not thread safe
  class BaseHandler
    def initialize(name)
      @name     = name
      @alive    = Time.now.to_i
      @counters = Hash.new { |h, k| h[k] = 0 }
      @options  = Hash.new
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
      @counters
    end

    def getCounter(key)
      @counters[key]
    end

    def setOption(key, value)
      @options[key] = value
    end

    def getOption(key)
      @options[key]
    end

    def getOptions
      @options
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
