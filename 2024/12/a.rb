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
		r,c = b.shift
		check = rows[r][c]
		next unless check == char

		a.append [r,c]
		Dir.D4(r,c).each do |nr,nc|
			next if a.has? [nr,nc]
			b.append [nr,nc]
		end
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

puts ans.s.bold.yellow
puts 1494342.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

