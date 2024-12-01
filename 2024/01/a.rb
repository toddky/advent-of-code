#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
NUMS  = file.readlines.map(&:numbers)

# ==============================================================================
# START CODE
# ==============================================================================
items = NUMS.transpose
a = items[0].sort
b = items[1].sort
ans = [a,b].transpose.map{|x,y| (x-y).abs }.sum

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 1834060.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

