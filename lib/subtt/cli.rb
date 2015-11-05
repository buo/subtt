#!/usr/bin/env ruby
# encoding: utf-8

require 'iconv'

$LOAD_PATH << File.expand_path('../..', __FILE__)
require 'subtt'

command = ARGV.shift
if ['smi2srt'].include? command
  Subtt.method(command).call ARGV.first
end
