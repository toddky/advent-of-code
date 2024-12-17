#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
# ==============================================================================
# SETUP
# ==============================================================================
require_relative '../../todd'

inputs = Hash.new
inputs[1] = 'input.txt'.read
inputs[2] = <<-EOF
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
EOF

# ==============================================================================
# CODE
# ==============================================================================

def op(a,b,c,pc,outputs,code)
	opcode, literal = code

	pc += 2

	case literal
	when 0..3 then combo = literal
	when 4    then combo = a
	when 5    then combo = b
	when 6    then combo = c
	when 7    then combo = nil
	end

	case opcode
	when 0 then a = a / (2**combo)
	when 1 then b = b ^ literal
	when 2 then b = combo % 8
	when 3 then pc = literal if a != 0
	when 4 then b = b ^ c
	when 5 then outputs.append (combo % 8)
	when 6 then b = a / (2**combo)
	when 7 then c = a / (2**combo)
	else
		p pc, code
		exit 99
	end

	return a,b,c,pc,outputs
end

def run_program(a,b,c,program)
	pc = 0
	outputs = []
	while pc < program.len
		code = [program[pc], program[pc+1]]
		a,b,c,pc,outputs = op(a,b,c,pc,outputs,code)
	end
	return outputs
end

def solve(inputs, select)
	input = inputs[select]
	nums = input.lines.map(&:numbers)
	a = nums[0].first
	b = nums[1].first
	c = nums[2].first
	program = nums[4]

	outputs = run_program(a,b,c,program)
	return outputs.join(',')
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, select)

real_ans = '2,0,4,2,7,0,1,0,3'
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

