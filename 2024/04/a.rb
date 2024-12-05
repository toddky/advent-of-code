#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[0] = 'input.txt'.read

inputs[1] = <<-EOF
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
EOF

inputs[2] = <<-EOF
...X...
..M.M..
.A...A.
S.....S
.A...A.
..M.M..
...X...
EOF

inputs[3] = <<-EOF
X...
.M..
..A.
...S
EOF
inputs[4] = inputs[3].lines.mreverse.join("\n")

input = inputs[0]
#input = inputs[4]
GRID = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
def xmas(str)
	return str.join.scan(/XMAS/).count + str.join.scan(/SAMX/).count
end

rows = GRID
ans += rows.map { |r| xmas(r) }.sum
ans += rows.t.map { |r| xmas(r) }.sum
ans += rows.diags.map { |r| xmas(r) }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 2532.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

