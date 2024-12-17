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
def can_move?(grid,r,c,dir)
	dr, dc = dir
	nr, nc = r+dr, c+dc
	o = grid[nr][nc]
	return true if o == '.'
	return false if o == '#'

	return can_move?(grid,nr,nc,dir)
end

def move(grid,r,c,dir)
	dr, dc = dir
	nr, nc = r+dr, c+dc

	move(grid,nr,nc,dir) unless grid[nr][nc] == '.'

	grid[nr][nc] = grid[r][c]
	grid[r][c] = '.'
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

	moves.each do |m|
		if can_move?(grid,r,c,dirs[m])
			move(grid,r,c,dirs[m])
			r = r + dirs[m][0]
			c = c + dirs[m][1]
		end
	end
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

