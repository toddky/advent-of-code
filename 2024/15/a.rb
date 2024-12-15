#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
EOF
inputs[3] = <<-EOF
##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
EOF

# ==============================================================================
# CODE
# ==============================================================================
def move(grid,r,c,dir)
	can_move = true
	fr, fc = r, c
	dr, dc = dir

	while true
		o = grid[fr][fc]
		return [r,c] if o == '#'

		if o == '.'
			dist = (fr-r+fc-c).abs

			dist.times do |d|
				d = dist - d -1

				r0 = r+((d+0)*dr)
				c0 = c+((d+0)*dc)
				r1 = r+((d+1)*dr)
				c1 = c+((d+1)*dc)

				grid[r1][c1] = grid[r0][c0]
			end

			grid[r][c] = '.'
			return [r+dr, c+dc]
		end

		fr += dr
		fc += dc
	end
end


def solve(inputs, select)
	input = inputs[select]
	chars = input.lines.mchars
	para = chars.split([])
	grid = para[0]
	#puts grid.mmjoin
	moves = para[1].flatten

	r,c = grid.gindex('@').flatten

	dirs = {
		'<' => [0,-1],
		'>' => [0,1],
		'^' => [-1,0],
		'v' => [1,0],
	}

	moves.each { |m| r,c = move(grid,r,c,dirs[m]) }
	#puts grid.mmjoin
	return grid.gindex('O').map { |r,c| 100*r + c }.sum
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 3
ans = solve(inputs, select)

real_ans = 1538871
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

