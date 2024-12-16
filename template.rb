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
def solve(inputs, select)
	input = inputs[select]

	lines    = input.lines
	para     = input.lines.split('')
	words    = input.lines.map(&:words)
	nums     = input.lines.map(&:numbers)
	abs_nums = input.lines.map(&:numbers).map(&:abs)
	chars    = input.lines.mchars
	csv      = input.lines.map{|line| line.split(',')}
	grid     = input.lines.mchars

	ans = 0

	rows = lines
	rows.mapi { |row, r| }
	rows.eachi do |row, r|
		#row.eachi do |col, |
		#end
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
input_stats(inputs[1])

#if not ARGV.empty?
#	select = ARGV.first.i
#	if not inputs.has_key? select
#		puts "#{"ERROR".b.red}: '#{select}' not found! Valid selections: #{inputs.keys.inspect}"
#		exit 1
#	end
#end

ans = solve(inputs, select)

real_ans = 0
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

