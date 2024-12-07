#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[0] = 'input.txt'.read
inputs[2] = <<-EOF
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
EOF

input = inputs[0]
#input = inputs[2]
NUMS  = input.lines.map(&:numbers)

# ==============================================================================
# CODE
# ==============================================================================
rows = NUMS

def check(inputs)
	result = inputs.shift
	results = [inputs.shift]
	inputs.each do |i|
		new_r = []
		results.each do |r|
			new_r.append(r + i)
			new_r.append(r * i)
			new_r.append((r.s + i.s).i)
		end
		results = new_r
	end
	return results.has?(result) ? result : 0
end

ans = rows.map { |row| check(row) }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 169122112716571.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

