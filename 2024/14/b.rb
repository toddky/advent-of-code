#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
EOF

# ==============================================================================
# CODE
# ==============================================================================
def solve(input)

	width = 101
	height = 103

	robots = input.lines.map(&:numbers)

	ans = 0
	while true
		ans += 1
		robots = robots.map { |x,y,vx,vy| [x+vx, y+vy, vx, vy] }
		pos = robots.map { |x,y,vx,vy| [x%width, y%height] }

		if pos.len == pos.uniq.len
			rows = Array.newa(height,width,' ')
			robots.each { |x,y,vx,vy| rows[y%height][x%width] = '#' }
			puts rows.mmjoin
			return ans
		end

	end
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
input = inputs[select]
ans = solve(input)

real_ans = 8159
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

