#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = 'example.txt'
#file = 'input.txt'
LINES = file.readlines
PARA  = file.readlines.split('')
WORDS = file.readlines.map(&:words)
NUMS  = file.readlines.map(&:numbers)
ABS   = file.readlines.map(&:numbers).map(&:abs)
CHARS = file.readlines.mchars
CSV   = file.readlines.map{|line| line.split(',')}
GRID  = file.readlines.mchars
rows, cols = GRID.rows, GRID.cols unless GRID.rows == 0
ans = 0

# ==============================================================================
# START CODE
# ==============================================================================
items = LINES
items.mapi { |item, i| }
items.eachi do |item, i|
end




# ==============================================================================
# END CODE
# ==============================================================================
puts ans.s.bold.yellow
puts 0.s.bold.green
ans.clipboard unless ans == 0

