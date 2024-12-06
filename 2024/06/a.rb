#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[0] = 'input.txt'.read
inputs[2] = <<-EOF
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
EOF

input = inputs[0]
#input = inputs[1]
#input = inputs[2]
LINES = input.lines
GRID  = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
puts "#{height}x#{width} grid".bold.blue if GRID.grid?

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
gr = LINES.index { |l| l.include? '^' }
gc = LINES[gr].chars.index('^')

# Border magic
#puts rows.mjoin.join("\n")
rows = rows.border(1,'X')
#puts rows.mjoin.join("\n")
gr += 1
gc += 1
#rows[gr][gc] = '.'
gdir = [-1, 0]

next_dir = {
	[-1,0] => [0,1],
	[0,1] => [1,0],
	[1,0] => [0,-1],
	[0,-1] => [-1,0]
}

pos = []
while rows[gr][gc] != 'X'
	pos.append([gc,gr])
	next_gr = gr + gdir[0]
	next_gc = gc + gdir[1]
	if rows[next_gr][next_gc] == '#'
		gdir = next_dir[gdir]
	end
	gr = gr + gdir[0]
	gc = gc + gdir[1]
end
ans = pos.uniq.len

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 5129.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

