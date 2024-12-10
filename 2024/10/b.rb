#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
.....0.
..4321.
..5..2.
..6543.
..7..4.
..8765.
..9....
EOF
inputs[3] = <<-EOF
...0...
...1...
...2...
6543456
7.....7
8.....8
9.....9
EOF
inputs[4] = <<-EOF
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
EOF

# ==============================================================================
# CODE
# ==============================================================================
def dfs(rows,r,c)
	n = rows[r][c]
	return 1 if n == 9

	count = 0
	Dir.D4.map { |dr,dc| [r+dr,c+dc] }.each do |r1,c1|
		n1 = rows[r1][c1]
		count += dfs(rows, r1, c1) if n1 == n + 1
	end
	return count
end


def solve(input)
	lines = input.lines
	rows = lines.map { |line| line.split('').map { |c| c == '.' ? -1 : c.i } }
	rows = rows.border(1,-1)

	starts = rows.gindex(0)
	ans = starts.map { |r,c| dfs(rows, r, c) }.sum
	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 4
input = inputs[select]
ans = solve(input)

puts ans.s.bold.yellow
puts 1034.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

