#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
params = Hash.new
inputs[1] = 'input.txt'.read
params[1] = [71, 1024]
inputs[2] = <<-EOF
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
EOF
params[2] = [7, 12]

# ==============================================================================
# CODE
# ==============================================================================
def solve(inputs, params, select=1)

	input = inputs[select]
	param = params[select]
	nums = input.lines.map(&:numbers)
	grid = input.lines.mchars

	max, first = param

	grid = Array.newa(max,max,'.')
	grid = grid.border(1,'#')

	nums[0..(first-1)].each do |r,c|
		r = r+1
		c = c+1
		grid[r][c] = '#'
	end

	flood = Array.newa(max+2,max+2,Inf)
	flood[max][max] = 0
	q = [[max,max]]
	while not q.empty?
		r,c = q.shift
		v = flood[r][c] + 1
		Dir.D4(r,c).each do |nr,nc|
			next if grid[nr][nc] == '#'
			if v < flood[nr][nc]
				flood[nr][nc] = v
				q.append([nr,nc])
			end
		end
	end
	#puts grid.transpose.mmjoin
	#puts flood.map { |row| row.map { |col| col.to_s.rjust(4) }.join(' ') }.join("\n")

	return flood[1][1]
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 316
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

