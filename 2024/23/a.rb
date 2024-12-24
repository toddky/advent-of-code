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
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def solve(inputs, params, select)
	input = inputs[select]
	lines = input.lines.map { |line| line.split('-') }

	graph = Hash.new

	rows = lines
	rows.each do |a,b|
		graph[a] ||= Set.new
		graph[a].append(b)

		graph[b] ||= Set.new
		graph[b].append(a)
		#graph[b].append a
	end

	sets = Set.new
	graph.sort.each do |k,v|
		v.to_a.combination(2).each do |a,b|
			sets.append([k,a,b].sort) if graph[a].has? b or graph[b].has? a
		end
	end
	return sets.select { |set| set.select { |a| a[0] == 't' }.len > 0 }.len
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 1308
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

