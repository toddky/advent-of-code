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

	#row.each_cons(2) { |a,b| a + b }
	#row.combination(2).each { |pair| p pair }

	#pq = Heap.new
	#pq = Heap.new { |a,b| a[0] > b[0] }
	#pq.push([a,b])
	#a,b = pq.pop

	return ans
end


# ==============================================================================
# SUBMIT
# ==============================================================================
input_stats(inputs[1])

sel = 1
sel = 2

ans = solve(inputs[sel], params[sel])

sel_s = "[#{sel}]".bold.blue
exp_ans = answers[sel]
puts "#{sel_s} #{ans.s.bold.yellow}"
puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"

exit unless sel != 1 and ans == exp_ans
sel = 1
ans = solve(inputs[sel], params[sel])
sel_s = "[#{sel}]".bold.blue
exp_ans = answers[sel]
puts "#{sel_s} #{ans.s.bold.yellow}"

if not exp_ans.nil?
	puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"
else
	File.write('answer.txt', ans)
	puts 'Wrote to answer.txt'
	ans.clipboard
	#submit(ans)
end

