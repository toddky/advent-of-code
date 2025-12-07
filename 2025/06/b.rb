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
answers[1] = 11602774058280

# Example input
inputs[2] = <<-EOF
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
EOF
params[2] = nil
answers[2] = 3263827


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	lines = input.lines

	ops = lines.map(&:words).last
	chars = input.lines.mchars
	nums = chars[0..-2].transpose.mjoin.i.split(0)

	ans = 0
	nums.eachi do |n, i|
		op = ops[i]
		if op == '*'
			ans += n.product
		else
			ans += n.sum
		end
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

