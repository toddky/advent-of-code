#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
EOF

inputs[3] = <<-EOF
#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################
EOF


# ==============================================================================
# CODE
# ==============================================================================
def dfs(grid,vals,r,c,dir,val,goal_r,goal_c)
	return nil if grid[r][c] == '#'

	cur_val = vals[r][c]
	if cur_val == -1
		vals[r][c] = val
		cur_val = val
	end
	if val < cur_val
		vals[r][c] = val
		cur_val = val
	end
	if r == goal_r and c == goal_c
		return cur_val
	end

	if val > cur_val
		return nil
	end
	results = []
	Dir.D4.each do |ndir|
		dr,dc = ndir
		nr,nc = r+dr,c+dc

		nval = val + 1
		nval += 1000 if dir != ndir

		results.append(dfs(grid,vals,nr,nc,ndir,nval,goal_r,goal_c))
	end

	return results.compact.min
end

def solve(inputs, select)
	#RUBY_THREAD_VM_STACK_SIZE=10000000 ruby ./a2.rb

	input = inputs[select]
	rows = input.lines.mchars
	start = rows.gindex('S').flatten
	finish = rows.gindex('E').flatten

	h = rows.height
	w = rows.width
	vals = Array.newa(h,w,-1)

	return dfs(rows,vals,start[0],start[1],[0,1],0,finish[0],finish[1])
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 3
input_stats(inputs[1])

ans = solve(inputs, select)

puts 89416.s.bold.red
puts 90416.s.bold.red

real_ans = 0
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

