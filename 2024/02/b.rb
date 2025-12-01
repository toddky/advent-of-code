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
	a = a.each_cons(2).map { |x,y| x-y }
	return false unless (a == a.abs) or (a == a.abs.mneg)
	return a.abs.all? { |x| x > 0 && x < 4 }
end

items.eachi do |item, row|
	item.eachi do |i, index|
		j = item.dup
		j.delete_at(index)
		if safe(j)
			ans += 1
			break
		end
	end
end

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 692.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

