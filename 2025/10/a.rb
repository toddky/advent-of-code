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
answers[1] = 449

# Example input
inputs[2] = <<-EOF
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
EOF
params[2] = nil
answers[2] = 7


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	words    = input.lines.map(&:words)

	ans = 0

	count = 0
	words.each do |w|
		final = w[0][1..-2].chars.map { |c| c == '.' ? 0 : 1 }
		buttons = w[1..-2].map(&:nums)
		count += 1

		best = Inf
		#puts
		#p 'buttons', buttons.len, buttons
		(2**(buttons.len)).times.each do |i|
			curr = Array.new(final.len, 0)
			i = i.to_s(2).rjust(buttons.len,'0').chars.i
			i.eachi do |j,k|
				next if j == 0
				buttons[k].each do |l|
					curr[l] = 1-curr[l]
				end
			end
			if curr == final
				#best = [best, i.count(1)].min
				best = i.count(1) if i.count(1) < best
			end
		end
		ans += best
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

