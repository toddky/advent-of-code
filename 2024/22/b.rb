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
1
2
3
2024
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def next_secrets(s,n=1)
	a = [s%10]
	(n-1).times do
		s = ((s * 64) ^ s) % 16777216
		s = ((s / 32) ^ s) % 16777216
		s = ((s * 2048) ^ s) % 16777216
		a.append(s%10)
	end
	return a
end

def get_seqs(s)
	code = next_secrets(s,2000)

	seqs = {}
	(0..1995).each do |i|
		bananas = code[i]
		seq = code[(i..(i+4))].each_cons(2).map { |a,b| a-b }
		next if seqs.has_key? seq
		seqs[seq] = bananas
	end
	return seqs
end

def solve(inputs, params, select)
	input = inputs[select]
	param = params[select]
	lines = input.lines

	all_seqs = {}
	lines.each do |row|
		get_seqs(row.i).each do |k,v|
			all_seqs[k] ||= []
			all_seqs[k].append(v)
		end
	end
	return all_seqs.values.map { |v| v.sum }.max
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 2044
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

