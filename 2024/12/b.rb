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
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
EOF
inputs[4] = <<-EOF
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
EOF


# ==============================================================================
# CODE
# ==============================================================================
require 'set'

def get_area(rows,r,c)

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

	return a
end

def solve(input)

	ans = 0
	grid = input.lines.mchars
	rows = grid
	rows = rows.flat_map { |row| [row.flat_map { |col| [col] * 2 }] * 2 }
	rows = rows.border(1,'.')
	#puts rows.mmjoin

	done = {}

	rows.eachi do |row,r|
		row.eachi do |col,c|
			next if done[[r,c]]
			next if col == '.'
			area = get_area(rows, r, c)

			corners = area.map { |r,c| Dir.D8(r,c).select { |point| area.has? point } }
			corners = corners.select { |c| c.len == 3 or c.len == 7 or c.len == 4 }

			result = (area.len/4) * corners.len
			ans += result
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
#select = 4
input = inputs[select]
ans = solve(input)

real_ans = 893676
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

