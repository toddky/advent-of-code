#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
AAAA
BBCD
BBCC
EEEC
EOF
inputs[3] = <<-EOF
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
EOF

# ==============================================================================
# CODE
# ==============================================================================
require 'set'

def prim(rows,r,c)

	a = Set.new
	b = Set.new([[r,c]])
	char = rows[r][c]

	while not b.empty?
		rc = b.shift
		r,c = rc
		next unless char == rows[r][c]
		a.append [r,c]
		Dir.D4(r,c).each { |nr,nc| b.append [nr,nc] unless a.has? [nr,nc] }
	end

	perim = a.map { |r,c| Dir.D4(r,c).select { |nr,nc| not a.has? [nr,nc] }.len }.sum
	return a, perim
end


def solve(input)

	ans = 0
	grid = input.lines.mchars
	rows = grid
	rows = rows.border(1,'.')
	#puts rows.mmjoin

	done = {}

	rows.eachi do |row,r|
		row.eachi do |col,c|
			next if done[[r,c]]
			next if col == '.'
			area, perim = prim(rows, r, c)
			ans += area.len * perim
			area.each { |a| done[a] = true }
		end
	end

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

real_ans = 1494342
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

