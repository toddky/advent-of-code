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
pages = PARA[0].map(&:numbers)
orders = PARA[1].map(&:numbers)

bads = []
orders.each do |order|
	sorted = pages.select { |x,y| order.has? x and order.has? y }.topsort
	bads.append(sorted) if sorted != order
end
ans = bads.map {|x| x[(x.len-1)/2] }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 4681.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

