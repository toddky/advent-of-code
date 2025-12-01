#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

input = <<-EOF
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
EOF

#input = 'example.txt'.read
input = 'input.txt'.read
LINES = input.lines
GRID  = input.lines.mchars
rows = GRID.len
cols = GRID.first.len
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
items = LINES

items.insert(0, '.' * cols)
items.push('.' * cols)
items = items.map { |i| '.' + i + '.' }
#puts items

pos = []

items.eachi do |i, row|
	pos += i.scan_all(/[0-9]+/).map { |s| [s[0].i, row, s.begin(0), s.end(0)] }
end

pos.each do |num, row, x, y|
	s = ''
	s += items[row-1][(x-1)..(y)]
	s += items[row][(x-1)..(y)]
	s += items[row+1][(x-1)..(y)]
	ans += num if s.gsub(/[\.0-9]/,'').len > 0
end

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 546563.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

