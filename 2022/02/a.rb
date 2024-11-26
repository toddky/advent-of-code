#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

#file = 'example.txt'
file = 'input.txt'
WORDS = file.readlines.map(&:words)
ans = 0

# ==============================================================================
# START CODE
# ==============================================================================
items = WORDS

# 1 for Rock, 2 for Paper, and 3 for Scissors
points = { X:1, Y:2, Z:3 }

# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors
# 0 if you lost, 3 if draw draw, and 6 if you won
game = {
	A: {X:3, Y:6, Z:0},
	B: {X:0, Y:3, Z:6},
	C: {X:6, Y:0, Z:3},
}

items.eachi do |item, i|
	a, b = item.sym
	ans += game[a][b] + points[b]
end

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 11666.s.bold.green
ans.clipboard unless ans == 0

