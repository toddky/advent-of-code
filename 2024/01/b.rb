#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
NUMS  = file.readlines.map(&:numbers)
ans = 0

# ==============================================================================
# START CODE
# ==============================================================================
items = NUMS.transpose
b = items[1].sort
NUMS.each { |a,_| ans += a* b.count(a) }

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 21607792.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

