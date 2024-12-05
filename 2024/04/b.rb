#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

input = <<-EOF
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
EOF

input = 'input.txt'.read
GRID = input.lines.mchars
height, width = GRID.height, GRID.width if GRID.grid?
puts "#{height}x#{width} grid".bold.blue if GRID.grid?
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
valid = %w(MMSS MSMS SSMM SMSM)
rows = rows.border(1,'.')

height.times do |r|
	width.times do |c|
		next unless rows[r][c] == 'A'
		corners = rows[r-1][c-1] + rows[r-1][c+1] + rows[r+1][c-1] + rows[r+1][c+1]
		ans += 1 if corners.in? valid
	end
end

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 1941.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

