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
rows = GRID
rows.mapi { |r, i| }

def xmas(str)
	return str.join.scan(/XMAS/).count + str.join.scan(/SAMX/).count
end

ans += rows.map { |r| xmas(r) }.sum
ans += rows.t.map { |r| xmas(r) }.sum

# top right
tri = rows.mapi { |r,i| r[i..-1] }.ljust
ans += tri.t.map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# bottom right
tri = rows.mapi { |r,i| r[(width-i-1)..-1] }.ljust
ans += tri.t.map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# top left
tri = rows.mapi { |r,i| r[0..(width-i-1)] }.rjust
ans += tri.t[0..-2].map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# bottom left
tri = rows.mapi { |r,i| r[0..i] }.rjust
ans += tri.t[0..-2].map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 2532.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

