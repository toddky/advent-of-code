#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

input = <<-EOF
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
EOF

input = 'input.txt'.read
NUMS  = input.lines.map(&:numbers)
ans = 0

# ==============================================================================
# CODE
# ==============================================================================
items = NUMS

def safe(a)
	a = (a.len-1).map { |i| a[i]-a[i+1] }
	return false unless (a == a.abs) or (a == a.abs.mneg)
	a = a.abs.sort
	return false if a[0] < 1
	return false if a[-1] > 3
	return true
end

items.eachi do |item, row|
	ans += 1 if safe(item)
end

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 663.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

