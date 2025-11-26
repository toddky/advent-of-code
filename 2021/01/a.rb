#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'
File.delete('answer.txt') if File.exists?('answer.txt')

inputs = Hash.new(nil)
params = Hash.new(nil)
answers = Hash.new(nil)

# Real input
inputs[1] = 'input.txt'.read
answers[1] = 1559
params[1] = nil

# Example input
inputs[2] = <<-EOF
199
200
208
210
200
207
240
269
260
263
EOF
answers[2] = 7
params[2] = nil


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	lines = input.lines
	rows = lines
	ans = rows.i.each_cons(2).map { |a,b| b>a }.count(true)
	return ans
end


# ==============================================================================
# SUBMIT
# ==============================================================================
sel = 1
exp_ans = answers[sel]
ans = solve(inputs[sel], params[sel])
puts "[#{sel}] #{ans.s.bold.yellow}".bold.blue
puts "[#{sel}] #{exp_ans.s.bold.green}".bold.blue unless exp_ans.nil?

