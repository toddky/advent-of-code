#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'input.txt'
LINES = file.readlines

# ==============================================================================
# CODE
# ==============================================================================
def start(s)
	s = s.chars
	len = s.size - 4
	(0..len).each do |i|
		return i + 4 if s[i..(i+3)].uniq.size == 4
	end
end

input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
input = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
input = LINES[0]
ans = start(input)

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 1766.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

