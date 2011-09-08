# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "scribe-rb"
  s.version     = "2.2.rc1"
  s.authors     = ["Andy Lindeman"]
  s.email       = ["andy@highgroove.com"]
  s.homepage    = "http://github.com/highgroove/scribe-rb"
  s.summary     = %q{Generated scribe and fb303 bindings for Ruby packed into a gem}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "thrift", "~>0.7.0"

  s.add_development_dependency "rake"
end
