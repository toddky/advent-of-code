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
PARA = input.lines.split('')

# ==============================================================================
# CODE
# ==============================================================================
pages, orders = PARA
pages = pages.map(&:numbers)
orders = orders.map(&:numbers)

def check(n, prev, pages)
	return true if prev.empty?
	current_prev = pages.select { |x,y| y == n }.map { |x,y| x }
	return prev.all? { |x| current_prev.include? x }
end

goods = []
orders.each do |order|
	prev = []
	good = true
	order.each do |n|
		if not check(n, prev, pages)
			good = false
			break
		end
		prev.append(n)
	end
	goods.append(order) if good
end
ans = goods.map {|x| x[(x.len-1)/2] }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 5091.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

