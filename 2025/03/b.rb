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
answers[1] = 172886048065379

# Example input
inputs[2] = <<-EOF
987654321111111
811111111111119
234234234234278
818181911112111
EOF
params[2] = nil
answers[2] = 3121910778619


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	def largest(num, n)
		num_s = num.s.chars
		len = num_s.len
		return num if n == len
		all = len.map { |i| num_s.rm(i).join.i }
		return largest(all.max, n)
	end

	#p [1,2,3].rm(1); exit

	#p largest(123,2); exit

	#p largest(123,2)
	#p largest(321,2)
	#p largest(123321,2)
	#exit

	return input.lines.map { |line| largest(line, 12) }.sum
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

