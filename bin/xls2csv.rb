#!/usr/bin/env ruby

args = $*.map { |x| x.include?(' ') ? "'" + x + "'" : x }
cmd = File.expand_path "#{File.dirname(__FILE__)}/../libexec/xls2csv"

exec "#{cmd} #{args.join(' ')}"