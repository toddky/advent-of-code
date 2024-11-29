#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

file = 'example.txt'
file = 'input.txt'
PARA  = file.readlines.split('')

# ==============================================================================
# START CODE
# ==============================================================================
stacks = PARA[0].map(&:chars).transpose
stacks = stacks.each_with_index.select { |_,i| i%4==1 }
stacks = stacks.map { |a| a[0].reverse[1..-1].map(&:strip).reject(&:empty?) }

moves = PARA[1].map(&:numbers)
moves.each do |num, from, to|
	stacks[to-1] += stacks[from-1].pop(num)
end

ans = stacks.map(&:last).join

# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 'SSCGWJCRB'.s.bold.green
ans.clipboard unless ans == 0

# ==============================================================================
# SUBMIT
# ==============================================================================
#submit(ans)

