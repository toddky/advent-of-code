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
	lines.each do |a,b|
		graph[a] ||= Set.new
		graph[a].append(b)
		graph[b] ||= Set.new
		graph[b].append(a)
	end

	max_len = 0
	max_set = []

	graph.each do |k,v|
		arr = [k] + v.to_a
		(arr.len).times.flat_map { |i| arr.combination(i).to_a }.each do |combo|
			next if combo.len <= max_len
			next unless combo.combination(2).map { |a,b| graph[a].has? b }.all? true
			max_set = combo
			max_len = max_set.len
		end
	end
	return max_set.sort.join(',')
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 'bu,fq,fz,pn,rr,st,sv,tr,un,uy,zf,zi,zy'
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

