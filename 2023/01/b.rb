#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'
file = ARGV[0] || 'input.txt'
ans = File.readlines(file).map { |line|
	line
		.gsub('one','one1one')
		.gsub('two','two2two')
		.gsub('three','three3three')
		.gsub('four','four4four')
		.gsub('five','five5five')
		.gsub('six','six6six')
		.gsub('seven','seven7seven')
		.gsub('eight','eight8eight')
		.gsub('nine','nine9nine')
		.gsub('zero','zero0zero')
}.map { |line| line[/\d/] + line.reverse[/\d/] }.sum
puts ans.s.bold.yellow
puts 54100.s.bold.green
