#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF

EOF

input = inputs[1]
input = inputs[2]
LINES = input.lines
PARA  = input.lines.split('')
WORDS = input.lines.map(&:words)
NUMS  = input.lines.map(&:numbers)
ABS   = input.lines.map(&:numbers).map(&:abs)
CHARS = input.lines.mchars
CSV   = input.lines.map{|line| line.split(',')}
GRID  = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
puts "#{height}x#{width} grid".bold.blue if GRID.grid?
input_stats(inputs[1])
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
rows = LINES
rows.mapi { |row, r| }
rows.eachi do |row, r|
end
p rows
#rows = rows.border(1,'X')
#puts rows.mmjoin


# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
#puts .s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

