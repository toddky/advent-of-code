#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new(nil)
params = Hash.new(nil)
inputs[1] = 'input.txt'.read
params[1] = nil
inputs[2] = <<-EOF
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def solve(inputs, params, select)
	input = inputs[select]
	param = params[select]
	para = input.lines.split('')

	@towels = Set.new para[0].first.split(', ')
	pats = para[1]

	def check(pat)
		return true if @towels.has? pat
		@towels.each do |t|
			next unless pat.start_with?(t)
			return true if check(pat.delete_prefix(t))
		end
		return false
	end
	memoize(:check)

	return pats.select { |pat| check(pat) }.len
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 330
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

