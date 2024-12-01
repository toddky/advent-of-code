#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

input = <<-EOF

EOF

input = 'example.txt'.read
#input = 'input.txt'.read
LINES = input.lines
PARA  = input.lines.split('')
WORDS = input.lines.map(&:words)
NUMS  = input.lines.map(&:numbers)
ABS   = input.lines.map(&:numbers).map(&:abs)
CHARS = input.lines.mchars
CSV   = input.lines.map{|line| line.split(',')}
GRID  = input.lines.mchars
rows, cols = GRID.rows, GRID.cols unless GRID.rows == 0
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
items = LINES
items.mapi { |item, i| }
items.eachi do |item, i|
end


# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
#puts .s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

