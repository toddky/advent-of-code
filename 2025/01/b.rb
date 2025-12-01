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
answers[1] = 6268

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
answers[2] = 6


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	rows = input.lines

	ans = 0
	start = 50

	rows.eachi do |row, r|
		dir = row[0]
		num = row[1..-1].i
		ans += num / 100
		num = num % 100
		if dir == 'L'
			ans += 1 if start <= num and start != 0
			start -= num
		else
			ans += 1 if start + num >= 100 and start != 0
			start += num
		end
		start = start % 100
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

