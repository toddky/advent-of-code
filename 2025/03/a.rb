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
answers[1] = 17435

# Example input
inputs[2] = <<-EOF
987654321111111
811111111111119
234234234234278
818181911112111
EOF
params[2] = nil
answers[2] = 357


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	chars = input.lines.mchars

	ans = 0
	chars.i.each do |nums|
		a = nums.max

		ai = nums.index(a)
		if ai == nums.len - 1
			b = a
			nums = nums[0..-2]
			a = nums.max
			ans += a*10 + b
			next
		end

		nums = nums[(nums.index(a)+1)..-1]
		b = nums.max
		ans += a*10 + b
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
puts "#{sel_s} #{exp_ans.nil? ? 'UNDEF'.bold.red : exp_ans.s.bold.green}"

