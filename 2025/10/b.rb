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
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
EOF
params[2] = nil
answers[2] = 33


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	words    = input.lines.map(&:words)

	ans = 0

	def dfs(curr, final, buttons)
		$global_i += 1
		return 0 if curr == final
		curr.zip(final).each { |a,b| return nil if a > b }

		buttons.each do |b|
			new_curr = curr.dup
			incr = b.map { |i| final[i] - new_curr[i] }.min
			next if incr == 0
			b.each do |i|
				new_curr[i] += incr
			end
			result = dfs(new_curr, final, buttons)
			#p 'result', $global_i, result.to_s, new_curr
			#exit
			return result + incr unless result.nil?
		end

		#p 'ERROR', $global_i
		#exit
		return nil
	end

	count = 0
	words.each do |w|
		final = w[-1].nums
		buttons = w[1..-2].map(&:nums).sort_by(&:len).reverse

		count += 1
		puts
		p count, final
		p 'buttons', buttons.len, buttons
		$global_i = 0
		result = dfs(Array.new(final.len, 0), final, buttons)
		p 'result', result
		ans += result
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

