#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[0] = 'input.txt'.read
inputs[1] = 'example.txt'.read
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
#input = inputs[2]
LINES = input.lines
GRID  = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
puts "#{height}x#{width} grid".bold.blue if GRID.grid?
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
gr = LINES.index { |l| l.include? '^' }
gc = LINES[gr].chars.index('^')

#puts rows.mjoin.join("\n")
rows = rows.border(1,'X')
#puts rows.mjoin.join("\n")
gr += 1
gc += 1
rows[gr][gc] = '.'
gpos = [gr,gc]

$next_dir = {
	[-1,0] => [0,1],
	[0,1] => [1,0],
	[1,0] => [0,-1],
	[0,-1] => [-1,0]
}

def is_loop(rows, gr, gc, o_r, o_c)
	orig = rows[o_r][o_c]
	return false if orig == '#'
	rows[o_r][o_c] = '#'
	gdir = [-1, 0]
	pos = {}
	while rows[gr][gc] != 'X'
		next_gr = gr + gdir[0]
		next_gc = gc + gdir[1]

		if rows[next_gr][next_gc] == '#'
			gdir = $next_dir[gdir]
		end

		gr = gr + gdir[0]
		gc = gc + gdir[1]
		if pos[[gc,gr,gdir]]
			rows[o_r][o_c] = orig
			return true
		end
		pos[[gc,gr,gdir]] = true
		#p pos
	end
	rows[o_r][o_c] = orig
	return false
end

height.times do |r|
	r = r + 1
	width.times do |c|
		c = c + 1
		#p "(#{r},#{c})"
		ans += 1 if is_loop(rows, gr, gc, r, c)
	end
	p r
end

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
#puts .s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

