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

def flood(grid,r,c, start)
	h = grid.height
	w = grid.width

	vals = Array.newa(h,w,-1)
	vals[r][c] = 0
	vecs = Dir.D4.map { |dir| [r,c,dir] }

	min = -1

	while not vecs.empty?
		r,c,dir = vecs.shift
		val = vals[r][c]
		Dir.D4().each do |ndir|
			dr,dc = ndir
			nr,nc = r+dr, c+dc

			next if grid[nr][nc] == '#'
			nval = val + 1
			nval += 1000 if dir != ndir

			if [nr,nc] == [start[0],start[1]]
				if min == -1
					min = nval
				end
				if nval < min
					min = nval
				end
			end


			if nval < vals[nr][nc] or vals[nr][nc] == -1
				vals[nr][nc] = nval

				vecs.append([nr,nc,ndir])
			end
		end
	end

	#puts vals.map { |row| row.map{|s| s.s.rjust(5)}.join(' ') }
	return vals
end

def dij(grid, finish)

	pq = Heap.new { |a,b| a[0] > b[0] }

	start_pos = grid.gindex('S').flatten
	r, c = start_pos
	dir = [0,1]

	pq.push([0,r,c,dir])

	visited = Set.new
	while not pq.empty?
		v, r, c, dir = pq.pop
		visited.add([r,c])
		return v if [r,c] == finish
		Dir.D4.each do |ndir|
			nr, nc = r+ndir[0], c+ndir[1]
			next if grid[nr][nc] == '#'
			next if visited.has? [nr,nc]
			nv = v + 1
			nv += 1000 if dir != ndir
			pq.push([nv,nr,nc,ndir])
		end
	end

end

def solve(inputs, select)
	input = inputs[select]
	rows = input.lines.mchars
	start = rows.gindex('S').flatten
	finish = rows.gindex('E').flatten

	return dij(rows, finish)

	#vals = flood(rows, finish[0], finish[1], [start[0],start[1],[0,1]])
	#return vals[start[0]][start[1]]
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 3

ans = solve(inputs, select)

real_ans = 88416
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

