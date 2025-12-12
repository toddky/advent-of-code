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
answers[1] = nil

# Example input
inputs[2] = <<-EOF
0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
EOF
params[2] = nil
answers[2] = 2


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	para = input.lines.split('')

	shapes = []
	para[0..-2].each do |shape|
		new_shape = []
		shape[1..-1].mchars.geach do |r,c,v|
			new_shape.append([r,c]) if v == '#'
		end
		shapes.append(new_shape)
	end

	ans = 0
	para[-1].each do |line|
		size, pieces = line.split(':')
		size = size.nums
		pieces = pieces.nums
		p 'region', size, pieces
	end
	return ans
end


# ==============================================================================
# SUBMIT
# ==============================================================================
input_stats(inputs[1])
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

