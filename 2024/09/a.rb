#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
2333133121414131402
EOF

input = inputs[1]
#input = inputs[2]
GRID  = input.lines.mchars

# ==============================================================================
# CODE
# ==============================================================================
rows = GRID
disk = []
len = 0
rows.first.i.each_slice(2).a.eachi do |a, id|
	len += a[0]
	disk += [id] * a[0]
	disk += Array.new(a[1] || 0, nil)
end

rev = disk.rev.compact

count = 0
disk.eachi do |a,i|
	next unless a.nil?
	disk[i] = rev[count]
	count += 1
end
disk = disk[0..len-1]

ans = disk.mapi { |a,i| a*i }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 6463499258318.s.bold.green

ans.clipboard unless ans == 0
#submit(ans)

