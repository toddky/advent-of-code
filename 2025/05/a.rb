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
answers[1] = 679


# Example input
inputs[2] = <<-EOF
3-5
10-14
16-20
12-18

1
5
8
11
17
32
EOF
params[2] = nil
answers[2] = 3


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	fresh, ids = input.lines.split('')
	fresh = fresh.map { |f| f.split('-').i }

	ans = 0
	ids.i.each do |id|
		ans += 1 if fresh.any? { |lo,hi| lo <= id and id <= hi }
	end

	return ans
end


# ==============================================================================
# SUBMIT
# ==============================================================================
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

