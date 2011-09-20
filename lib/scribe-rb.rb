# Unfortunately the thrift generated files assume all the files are in the
# load path
$LOAD_PATH.push(File.expand_path("generated", File.dirname(__FILE__)))
require File.expand_path("generated/scribe", File.dirname(__FILE__))

require File.expand_path("extras/facebook_base_handler", File.dirname(__FILE__))
require File.expand_path("extras/non_strict_binary_protocol_factory", File.dirname(__FILE__))
require File.expand_path("extras/queued_log_message_handler", File.dirname(__FILE__))
