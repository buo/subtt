# encoding: utf-8
$:.unshift File.expand_path("../lib/", __FILE__)
require "subtt/version"

Gem::Specification.new do |s|
  s.name        = "subtt"
  s.version     = Subtt::VERSION
  s.licenses    = ["MIT"]
  s.authors     = ["buo"]
  s.email       = ["buo@users.noreply.github.com"]
  s.homepage    = "https://github.com/buo/subtt"
  s.summary     = "A command line tool for converting subtitle files."
  s.description = "A command line tool for converting a subtitle file into another format."
  s.files = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }

  s.bindir        = "bin"
  s.executables   = %w(smi2srt)
end
