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
require 'set'

def det(a,b,c,d) return a*d - b*c; end

def game(g)
	xa, ya = g[0].nums
	xb, yb = g[1].nums
	xp, yp = g[2].nums

	large = 10000000000000
	xp += large
	yp += large

	# a * xa + b * xb = xp
	# a * ya + b * yb = yp
	press_a, ra = det(xp,xb,yp,yb).divmod(det(xa,xb,ya,yb))
	press_b, rb = det(xa,xp,ya,yp).divmod(det(xa,xb,ya,yb))
	return 3 * press_a + press_b if ra == 0 and rb == 0
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

input = inputs[select]
ans = solve(input)

real_ans = 101726882250942
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

