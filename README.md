# Scribe For Ruby Made Easy

[![Build Status](https://secure.travis-ci.org/highgroove/scribe-rb.png)](http://travis-ci.org/highgroove/scribe-rb)

To use [Scribe](https://github.com/facebook/scribe), you usually have to
use [Apache Thrift](http://thrift.apache.org/) to generate Ruby code
from generic *.thrift files.

This gem tries to alleviate that slight annoyance and package everything
you need to communicate with Scribe.

## Installation

Add to Gemfile:

```ruby
gem 'scribe-rb'
```

## Producer (Client)

```ruby
# Setup
socket = Thrift::Socket.new('localhost', 1463)

transport = Thrift::FramedTransport.new(socket)
transport.open

protocol = Thrift::BinaryProtocol.new(transport, false)
client   = Scribe::Client.new(protocol)

# Logging
log_entry = LogEntry.new(:category => 'default', :message => 'This is a test message')
client.Log([log_entry])

# Teardown
transport.close
```

## Consumer (Server)

```ruby
# Define a handler that inherits from FacebookService::BaseHandler
class MyScribeHandler < FacebookService::BaseHandler
  def Log(messages)
    # Process the array of LogEntry instances passed
    messages.each do |message|
      puts "#{message.category}: #{message.message}"
    end

    # If messages were processed correctly, return `ResultCode::OK`
    #
    # To tell the Scribe producer/broker to resend messages later (e.g.,
    # because this process is under too much load), return
    # `ResultCode::TRY_LATER`

    # Must return `ResultCode::OK` or `ResultCode::TRY_LATER`
    ResultCode::OK
  end
end

# Setup
handler   = MyScribeHandler.new("My Scribe Handler")
processor = Scribe::Processor.new(handler)

transport = Thrift::ServerSocket.new(5678) # 5678 is port number

transportFactory = Thrift::FramedTransportFactory.new
protocolFactory  = Thrift::NonStrictBinaryProtocolFactory.new

# There are multiple options for server type
# * [Thrift::SimpleServer](http://rubydoc.info/gems/thrift/0.7.0/Thrift/SimpleServer): single threaded server (simplest)
# * [Thrift::ThreadedServer](http://rubydoc.info/gems/thrift/0.7.0/Thrift/ThreadedServer): server that spawns a thread to handle messages
# * [Thrift::ThreadPoolServer](http://rubydoc.info/gems/thrift/0.7.0/Thrift/ThreadPoolServer): server that uses a constant number of threads as workers
# * [Thrift::NonblockingServer](http://rubydoc.info/gems/thrift/0.7.0/Thrift/NonblockingServer): server that uses non-blocking I/O
server = Thrift::SimpleServer.new(processor, transport, transportFactory, protocolFactory)
server.serve
```

## Hat Tips

* [Installing and Using Scribe with Ruby on Mac OS](http://kpumuk.info/development/installing-and-using-scribe-with-ruby-on-mac-os/)
* [Ruby Web-Services with Facebook’s Thrift](http://www.igvita.com/2007/11/30/ruby-web-services-with-facebooks-thrift/)

## License

Copyright (c) 2011 Highgroove Studios

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
