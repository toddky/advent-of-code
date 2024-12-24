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
x00: 1
x01: 1
x02: 1
y00: 0
y01: 1
y02: 0

x00 AND y00 -> z00
x01 XOR y01 -> z01
x02 OR y02 -> z02
EOF
params[2] = nil

inputs[3] = <<-EOF
x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
y00: 1
y01: 1
y02: 1
y03: 1
y04: 1

ntg XOR fgs -> mjb
y02 OR x01 -> tnw
kwq OR kpj -> z05
x00 OR x03 -> fst
tgd XOR rvg -> z01
vdt OR tnw -> bfw
bfw AND frj -> z10
ffh OR nrd -> bqk
y00 AND y03 -> djm
y03 OR y00 -> psh
bqk OR frj -> z08
tnw OR fst -> frj
gnj AND tgd -> z11
bfw XOR mjb -> z00
x03 OR x00 -> vdt
gnj AND wpb -> z02
x04 AND y00 -> kjc
djm OR pbm -> qhw
nrd AND vdt -> hwm
kjc AND fst -> rvg
y04 OR y02 -> fgs
y01 AND x02 -> pbm
ntg OR kjc -> kwq
psh XOR fgs -> tgd
qhw XOR tgd -> z09
pbm OR djm -> kpj
x03 XOR y03 -> ffh
x00 XOR y04 -> ntg
bfw OR bqk -> z06
nrd XOR fgs -> wpb
frj XOR qhw -> z04
bqk OR frj -> z07
y03 OR x01 -> nrd
hwm AND bqk -> z03
tgd XOR rvg -> z12
tnw OR pbm -> gnj
EOF

# ==============================================================================
# CODE
# ==============================================================================

def solve(inputs, params, select)
	input = inputs[select]
	para = input.lines.split('')

	ans = 0

	vals = para[0].map { |line| line.split(': ') }.to_h
	eqs = para[1].map { |line| line.split(' ') }

	until eqs.empty?
		eq = eqs.shift
		a, op, b, _, res = eq

		unless vals.has_key? a
			eqs.append(eq)
			next
		end
		unless vals.has_key? b
			eqs.append(eq)
			next
		end

		a = vals[a].to_i
		b = vals[b].to_i
		case op
		when 'AND' then c = a & b
		when 'OR'  then c = a | b
		when 'XOR' then c = a ^ b
		end
		vals[res] = c
	end

	keys = vals.keys.select { |key| key[0] == 'z' }.sort.reverse
	keys.each { |k| ans = ans * 2 + vals[k] }
	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2
#select = 3

ans = solve(inputs, params, select)

real_ans = 52038112429798
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

