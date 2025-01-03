#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
NUMS = file.readlines.map(&:numbers)

# ==============================================================================
# START CODE
# ==============================================================================
ans = NUMS.t.msort.t.map{|x,y| x-y}.mabs.sum

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 1834060.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

