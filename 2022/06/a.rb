#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

# ==============================================================================
# CODE
# ==============================================================================
def solve(s)
	s = s.chars
	len = s.size - 4
	(0..len).each do |i|
		return i + 4 if s[i..(i+3)].uniq.size == 4
	end
end

# ==============================================================================
# END
# ==============================================================================
inputs = Hash.new
answers = Hash.new

inputs[1] = 'input.txt'.read
answers[1] = 1766

inputs[2] = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
answers[2] = 7

inputs[3] = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
answers[3] = 5

select = 1
ans = solve(inputs[select])
puts ans.s.bold.yellow
puts answers[select].s.bold.green if answers.has_key? select
ans.clipboard if select == 1
#submit(ans)

