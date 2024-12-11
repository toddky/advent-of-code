#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
0 1 10 99 999
EOF
inputs[3] = <<-EOF
125 17
EOF

# ==============================================================================
# CODE
# ==============================================================================
def stone(s)
	return 1 if s == 0
	if s.s.len % 2 == 0
		return s.s.chars.each_slice(s.s.len/2).a.mjoin.i
	end
	return s*2024
end

def solve(input)
	nums = input.lines.map(&:numbers)
	rows = nums.flatten
	25.times do
		rows = rows.map { |r| stone(r) }.flatten
	end
	ans = rows.len
	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 3
input = inputs[select]
ans = solve(input)

puts ans.s.bold.yellow
puts 190865.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

