#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
EOF

# ==============================================================================
# CODE
# ==============================================================================
def game(g)
	a = g[0].nums
	b = g[1].nums
	px,py = g[2].nums

	101.times do |press_b|

		bx = b[0] * press_b
		by = b[1] * press_b

		press_ax, remain_ax = (px-bx).divmod(a[0])
		press_ay, remain_ay = (py-by).divmod(a[1])

		if remain_ax == 0 and remain_ay == 0 and press_ax == press_ay
			return press_b + press_ax * 3
		end
	end
	return 0
end

def solve(input)
	games = input.lines.split('')
	return games.map { |g| game(g) }.sum
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
input_stats(inputs[1])

input = inputs[select]
ans = solve(input)

real_ans = 27105
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

