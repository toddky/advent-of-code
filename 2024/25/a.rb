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
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================

def solve(inputs, params, select)
	input = inputs[select]
	para = input.lines.split('')

	locks = []
	keys = []
	para.each do |para|
		vals = para.map(&:chars).t.map { |s| s.count('#') - 1 }
		if para[0] == '#####'
			locks.append(vals)
		else
			keys.append(vals)
		end
	end

	return locks.flat_map { |lock| keys.map { |key| [lock,key].t.select { |a,b| a+b > 5}.empty? } }.count { |a| a }
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 3287
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

