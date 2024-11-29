#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
LINES = file.readlines
ans = 0

# ==============================================================================
# START CODE
# ==============================================================================
items = LINES
items = items.map { |i| i.chunks_of(i.len.half) }

items.each do |a, b|
	c = a & b
	value = c.ord - 'a'.ord + 1
	# Uppercase
	value += 32 + 26 if value < 0
	ans += value
end

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 7917.s.bold.green
ans.clipboard unless ans == 0

