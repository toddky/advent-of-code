#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[0] = 'input.txt'.read
inputs[2] = <<-EOF
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
EOF

input = inputs[0]
#input = inputs[2]
PARA  = input.lines.split('')

# ==============================================================================
# CODE
# ==============================================================================
pages, orders = PARA
pages = pages.map(&:numbers)
orders = orders.map(&:numbers)

page_map = {}
pages.map { |x,y| y }.uniq.each do |n|
	page_map[n] = pages.select { |x,y| y == n }.map { |x,y| x }
end

def check(prev, page_map)
	prev.eachi do |n,i|
		next if i == 0
		c = page_map[n]
		return false unless prev.first(i).all? { |x| c.include? x }
	end
	return true
end

bads = []

orders.each do |order|
	prev = []
	good = true
	order.each do |n|
		if check(prev+[n], page_map)
			prev.append(n)
			next
		end
		good = false

		fixed = false
		(prev.len+1).each do |i|
			prev2 = prev.dup
			prev2.insert(i,n)
			if check(prev2, page_map)
				prev = prev2
				fixed = true
				break
			end
		end
	end

	bads.append(prev) if not good
end
ans = bads.map {|x| x[(x.len-1)/2] }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 4681.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

