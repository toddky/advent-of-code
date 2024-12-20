#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

input = <<-EOF
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
EOF
input = 'input.txt'.read

# ==============================================================================
# CODE
# ==============================================================================
def mul(str); str.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map{|x|x.i.prod}.sum; end
ans = input.split('do()').map { |i| mul(i.split("don't()")[0]) }.sum

# ==============================================================================
# END
# ==============================================================================
puts ans.s.bold.yellow
puts 100189366.s.bold.green
ans.clipboard unless ans == 0
#submit(ans)

