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
GRID  = input.lines.mchars
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
valid = ['MMSS', 'MSMS', 'SSMM', 'SMSM']

(rows.len-2).a.each do |r|
	row = rows[r]
	(row.len-2).a.each do |c|
		#puts rows[r][c..(c+2)].join
		#puts rows[r+1][c..(c+2)].join
		#puts rows[r+2][c..(c+2)].join
		next unless rows[r+1][c+1] == 'A'
		corners = rows[r][c] + rows[r][c+2] + rows[r+2][c] + rows[r+2][c+2]
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

