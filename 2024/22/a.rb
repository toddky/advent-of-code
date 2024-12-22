#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new(nil)
params = Hash.new(nil)
inputs[1] = 'input.txt'.read
params[1] = nil
inputs[2] = <<-EOF
1
10
100
2024
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def next_secret(s,n=1)
	n.times do
		s = ((s * 64) ^ s) % 16777216
		s = ((s / 32) ^ s) % 16777216
		s = ((s * 2048) ^ s) % 16777216
	end
	return s
end

def solve(inputs, params, select)
	input = inputs[select]
	param = params[select]
	lines = input.lines
	return lines.map { |s| next_secret(s.i,2000) }.sum
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 18261820068
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

