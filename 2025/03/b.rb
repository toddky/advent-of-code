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
	chars = input.lines.mchars

	def largest(nums, n=1)
		return nil if nums.len == 0

		max = nums.max
		return max if n == 1
		i = nums.index(max)

		vals = []

		left = largest(nums[0..(i-1)], n-1)
		if not left.nil? and i != 0
			vals.append((left.s + max.s).i)
		end
		

		right = largest(nums[(i+1)..-1], n-1)
		if not right.nil?
			vals.append((max.s + right.s).i)
		end

		# REVISIT: If vals is empty, pick a different max
		return nil if vals.empty?

		#max = [left, right].max
		max = vals.max

		return max
	end

	p largest(987654321111111.s.chars.i,12)
	p 987654321111

	p largest(811111111111119.s.chars.i,12)
	p 811111111119

	p largest(234234234234278.s.chars.i,12)
	p 434234234278

	p largest(818181911112111.s.chars.i,12)
	p 888911112111

	ans = 0
	chars.i.each do |nums|
		ans += largest(nums, 12)
	end
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

