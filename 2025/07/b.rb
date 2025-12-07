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
answers[1] = 15650261281478

# Example input
inputs[2] = <<-EOF
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
EOF
params[2] = nil
answers[2] = 40


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	grid = input.lines.mchars

	start = grid.first.index('S')
	splits = grid.gmap { |r,c,v| v == '^' ? c : nil }.map(&:compact)

	def paths(splits, r, c)
		return 1 if r == splits.len
		if splits[r].has? c
			left = paths(splits, r+1, c-1)
			right = paths(splits, r+1, c+1)
			return left + right
		else
			return paths(splits, r+1, c)
		end
	end
	memoize(:paths)

	return paths(splits, 0, start)
end


# ==============================================================================
# SUBMIT
# ==============================================================================
sel = 1
sel = 2
ans = solve(inputs[sel], params[sel])
sel_s = "[#{sel}]".bold.blue
exp_ans = answers[sel]
puts "#{sel_s} #{ans.s.bold.yellow}"
puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"

exit unless sel != 1 and ans == exp_ans
sel = 1
ans = solve(inputs[sel], params[sel])
sel_s = "[#{sel}]".bold.blue
exp_ans = answers[sel]
puts "#{sel_s} #{ans.s.bold.yellow}"

if not exp_ans.nil?
	puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"
else
	File.write('answer.txt', ans)
	puts 'Wrote to answer.txt'
	ans.clipboard
	#submit(ans)
end

