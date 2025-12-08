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
params[1] = 1000
answers[1] = 8420405530

# Example input
inputs[2] = <<-EOF
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
EOF
params[2] = 10
answers[2] = 25272


# ==============================================================================
# CODE
# ==============================================================================
def solve(input, param)
	nums = input.lines.map(&:numbers)

	def dist(p1,p2)
		x1,y1,z1 = p1
		x2,y2,z2 = p2
		return Math.sqrt((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)
	end

	dists = nums.combination(2).map { |a,b| [a,b,dist(a,b)] }.sort_by { |n| n[2] }

	count = 0
	inc = 1
	conns = {}
	dists.each do |a,b,_|
		if not conns.has_key? a and not conns.has_key? b
			count += 1
			conns[a] = inc
			conns[b] = inc
			inc += 1

		elsif conns.has_key? a and conns.has_key? b
			if conns[a] == conns[b]
				count += 1
				next
			end
			count += 1

			new_val = conns[a]
			old_val = conns[b]
			conns.each do |conn,val|
				if val == old_val
					conns[conn] = new_val
				end
			end

		elsif conns.has_key? a
			count += 1
			conns[b] = conns[a]
		elsif conns.has_key? b
			count += 1
			conns[a] = conns[b]
		else
			p 'WTF'
			exit
		end

		if conns.keys.len == nums.len
			return a[0] * b[0]
		end
	end
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

