#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
WORDS = file.readlines.map(&:words)
ans = 0

# ==============================================================================
# START CODE
# ==============================================================================
items = WORDS

# 1 for Rock, 2 for Paper, and 3 for Scissors
points = { R:1, P:2, S:3 }

# A for Rock, B for Paper, and C for Scissors
# 0 if you lost, 3 if you draw, and 6 if you won
# X means you need to lose
# Y means you need to draw
# Z means you need to win
game = {
	A: {X:0, Y:3, Z:6},
	B: {X:0, Y:3, Z:6},
	C: {X:0, Y:3, Z:6},
}
hand = {
	A: {X:'S', Y:'R', Z:'P'},
	B: {X:'R', Y:'P', Z:'S'},
	C: {X:'P', Y:'S', Z:'R'},
}

items.eachi do |item, i|
	a, b = item.sym
	ans += game[a][b]
	ans += points[hand[a][b].sym]
end

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 12767.s.bold.green
ans.clipboard unless ans == 0

