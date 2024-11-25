#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'
file = ARGV[0] || 'input.txt'
ans = File.readlines(file).map { |line| line[/\d/] + line.reverse[/\d/] }.sum
puts ans.s.bold.yellow
puts 54877.s.bold.green
