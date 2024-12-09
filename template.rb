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

# ==============================================================================
# CODE
# ==============================================================================
def solve(input)

	lines    = input.lines
	para     = input.lines.split('')
	words    = input.lines.map(&:words)
	nums     = input.lines.map(&:numbers)
	abs_nums = input.lines.map(&:numbers).map(&:abs)
	chars    = input.lines.mchars
	csv      = input.lines.map{|line| line.split(',')}
	grid     = input.lines.mchars

	# Grid
	height, width = grid.height, grid.width if grid.grid?
	puts "#{height}x#{width} grid".bold.blue if grid.grid?

	ans = 0

	rows = lines
	rows.mapi { |row, r| }
	rows.eachi do |row, r|
	end
	p rows
	#rows = rows.border(1,'X')
	#puts rows.mmjoin

	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
select = 2
input = inputs[select]
input_stats(inputs[1])
ans = solve(input)

puts ans.s.bold.yellow
#puts .s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

