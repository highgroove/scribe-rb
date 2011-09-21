# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "scribe-rb"
  s.version     = "2.2.rc6"
  s.authors     = ["Andy Lindeman"]
  s.email       = ["andy@highgroove.com"]
  s.homepage    = "http://github.com/highgroove/scribe-rb"
  s.summary     = %q{Generated scribe and fb303 bindings for Ruby packed into a gem}
  s.description = %q{Everything you need to build a Ruby producer/client or consumer/server of Scribe messages}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "thrift", "~>0.7.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~>2.6.0"
  s.add_development_dependency "timecop"
end
