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

def count(s, n)
	return 1 if n == 0
	return count(1,n-1) if s == 0

	str = s.s
	len = str.len
	if len % 2 == 0
		left, right = str.chars.each_slice(s.s.len/2).map { |a| a.join.i }
		return count(left,n-1) + count(right,n-1)
	end

	return count(s*2024,n-1)
end

memoize(:count)

def solve(input)
	nums = input.lines.map(&:numbers)
	rows = nums.flatten
	ans = rows.map { |r| count(r,75) }.sum
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
puts 225404711855335.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

