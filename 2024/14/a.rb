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
def solve(inputs, select)
	input = inputs[select]

	if select == 1
		width = 101
		height = 103
	else
		width = 11
		height = 7
	end

	robots = input.lines.map(&:numbers)
	pos = robots.map { |x,y,vx,vy| [(x+100*vx) % width, (y+100*vy) % height] }

	ans = 1
	ans *= pos.select { |x,y| x < width/2 and y < height / 2 }.len
	ans *= pos.select { |x,y| x < width/2 and y > height / 2 }.len
	ans *= pos.select { |x,y| x > width/2 and y < height / 2 }.len
	ans *= pos.select { |x,y| x > width/2 and y > height / 2 }.len

	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
ans = solve(inputs, select)

real_ans = 231852216
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

