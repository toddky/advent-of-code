#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = 'example.txt'
file = 'input.txt'
PARA  = file.readlines.split('')

# ==============================================================================
# START CODE
# ==============================================================================
ans = PARA.map { |a| a.i.sum }.max

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 72017.s.bold.green
ans.clipboard unless ans == 0

