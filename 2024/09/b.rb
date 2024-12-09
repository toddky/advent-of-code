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
	disk.append([id,a[0]])
	disk.append([nil,a[1]||0])
end

compact = []

puts
rev = disk.select { |a| not a[0].nil? }.rev

rev.each do |block|

	id = block[0]
	i = disk.index { |a| a[0].nil? and a[1] >= block[1] }
	next if i.nil?
	d = disk.index { |a| a == block }
	next if i >= d
	d = disk.index { |a| a == block }

	dsize = block[1]
	if disk[d+1][0].nil?
		dsize += disk[d+1][1]
		disk.delete_at(d+1)
	end
	if disk[d-1][0].nil?
		dsize += disk[d-1][1]
	end
	disk[d] = [nil, dsize]
	if disk[d-1][0].nil?
		disk.delete_at(d-1)
	end

	empty_size = disk[i][1]-block[1]
	disk[i] = block
	if empty_size != 0
		disk.insert(i+1,[nil,empty_size])
	end

end

ans = disk.map { |a,b| [(a || 0)] * b }.flatten.mapi { |a,b| a*b }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 6493634986625.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

