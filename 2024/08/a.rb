#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
EOF
inputs[3] = <<-EOF
..........
..........
..........
....a.....
........a.
.....a....
..........
......A...
..........
..........
EOF

input = inputs[1]
#input = inputs[2]
#input = inputs[3]
GRID  = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
chars = input.lines.join.gsub('.','').chars.uniq
def get_pos(rows, char)
	return rows.each_with_index.flat_map { |row,r| row.each_index.select { |c| row[c] == char }.map {|c| [r,c]} }
end

def valid(r,c,height,width)
	return (r >= 0) && (c >= 0) && (r < height) && (c < width)
end

all_pos = []
chars.each do |c|
	pos = get_pos(rows, c)
	pos.combs(2).a.each do |a, b|
		ax, ay = a
		bx, by = b
		dx = ax - bx
		dy = ay - by
		all_pos.append([ax+dx,ay+dy])
		all_pos.append([bx-dx,by-dy])
	end
end
ans = all_pos.select { |a| valid(a[0], a[1], height, width) }.uniq.len

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 396.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

