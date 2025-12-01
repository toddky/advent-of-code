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
params[1] = nil
answers[1] = 1086

# Example input
inputs[2] = <<-EOF
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
EOF
params[2] = nil
answers[2] = 3


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	rows = input.lines
	ans = 0
	start = 50

	rows.eachi do |row, r|
		dir = row[0]
		n = row[1..-1].i
		if dir == 'L'
			start -= n
		else
			start += n
		end
		start = start % 100
		ans += 1 if start == 0
	end

	return ans
end


# ==============================================================================
# SUBMIT
# ==============================================================================
sel = 1
ans = solve(inputs[sel], params[sel])
sel_s = "[#{sel}]".bold.blue
exp_ans = answers[sel]
puts "#{sel_s} #{ans.s.bold.yellow}"
puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"

