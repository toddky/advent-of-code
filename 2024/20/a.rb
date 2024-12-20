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
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def flood(grid)
	start = grid.gindex('S').flatten
	fin = grid.gindex('E').flatten

	vals = Hash.new(Inf)
	q = [[0, fin[0], fin[1]]]
	until q.empty?
		v,r,c, = q.shift
		next if v >= vals[[r,c]]
		vals[[r,c]] = v
		nv = v + 1

		Dir.D4(r,c).each do |nr,nc|
			next if grid[nr][nc] == '#'
			q.append([nv,nr,nc])
		end
	end
	return vals
end

def solve(inputs, params, select)
	input = inputs[select]
	param = params[select]
	grid = input.lines.mchars
	rows = grid

	vals = flood(rows)

	savings = []
	rows.eachi do |row, r|
		row.eachi do |col, c|
			next unless col == '#'
			savings.append(vals[[r-1,c]]-vals[[r+1,c]])
			savings.append(vals[[r,c-1]]-vals[[r,c+1]])
		end
	end

	return savings.select { |s| s.finite? and s.abs >= 102 }.len
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 1338
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

