#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'
File.delete('answer.txt') if File.exists?('answer.txt')

inputs = Hash.new(nil)
params = Hash.new(nil)
answers = Hash.new(nil)

# Real input
inputs[1] = 'input.txt'.read
params[1] = nil
answers[1] = nil

# Example input
inputs[2] = <<-EOF

EOF
params[2] = nil
answers[2] = nil

# ==============================================================================
# CODE
# ==============================================================================

def solve(input, param)
	lines    = input.lines
	para     = input.lines.split('')
	words    = input.lines.map(&:words)
	nums     = input.lines.map(&:numbers)
	abs_nums = input.lines.map(&:numbers).map(&:abs)
	chars    = input.lines.mchars
	csv      = input.lines.map{|line| line.split(',')}
	grid     = input.lines.mchars

	dirs = { '<' => [0,-1], '>' => [0,1], '^' => [-1,0], 'v' => [1,0] }

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

	#pq = Heap.new
	#pq = Heap.new { |a,b| a[0] > b[0] }

	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
sel = 1
sel = 2
input_stats(inputs[1])

exp_ans = answers[sel]
ans = solve(inputs[sel], params[sel])
puts "[#{sel}] #{ans.s.bold.yellow}".bold.blue
puts "[#{sel}] #{exp_ans.s.bold.green}".bold.blue unless exp_ans.nil?

do_real = true
#do_real = false
if do_real and not exp_ans.nil? and ans == exp_ans and sel != 1 then
	real_ans = answers[1]
	ans = solve(inputs[1], params[1])
	puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans.nil?
	File.write('answer.txt', ans)
	puts 'Wrote to answer.txt'
	ans.clipboard
	#submit(ans)
end

