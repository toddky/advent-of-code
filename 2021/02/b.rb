#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new(nil)
params = Hash.new(nil)
answers = Hash.new(nil)

# Real input
inputs[1] = 'input.txt'.read
params[1] = nil
answers[1] = 1463827010

# Example input
inputs[2] = <<-EOF
forward 5
down 5
forward 8
up 3
down 8
forward 2
EOF
params[2] = nil
answers[2] = 900


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	words = input.lines.map(&:words)

	pos = 0
	depth = 0
	aim = 0
	words.each do |dir, dist|
		dist = dist.i
		if dir == 'forward'
			pos += dist
			depth += aim * dist
		end
		aim += dist if dir == 'down'
		aim -= dist if dir == 'up'
	end

	return pos * depth
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

