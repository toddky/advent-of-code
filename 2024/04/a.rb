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
GRID = input.lines.mchars
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
tri = []
rows.eachi do |r,i|
	new = r[i..-1]+Array.new(i,' ')
	tri.append(new)
end
ans += tri.t.map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# bottom right
tri = []
rows.eachi do |r,i|
	len = r.len
	new = r[(len-i-1)..-1]+Array.new(len-i,' ')
	tri.append(new)
end
ans += tri.t.map { |r| xmas(r) }.sum
#puts tri.t.mjoin.join("\n")

# top left
tri = []
rows.eachi do |r,i|
	len = r.len
	new = Array.new(i,' ')+r[0..(len-i-1)]
	tri.append(new)
end
tri.t.eachi do |r, i|
	next if i == r.len - 1
	ans += xmas(r)
end
#puts tri.t.mjoin.join("\n")

# bottom left
tri = []
rows.eachi do |r,i|
	len = r.len
	new = Array.new(len-i-1,' ')+r[0..i]
	tri.append(new)
end
tri.t.eachi do |r, i|
	next if i == r.len - 1
	ans += xmas(r)
end
#puts tri.t.mjoin.join("\n")

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 2532.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

