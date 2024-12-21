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
029A
980A
179A
456A
379A
EOF
params[2] = nil

# ==============================================================================
# CODE
# ==============================================================================
def a2b(start,fin,pad)
	pad = pad.border

	start = pad.gindex(start.s).flatten
	fin = pad.gindex(fin.s).flatten
	fr,fc = fin

	paths = []
	q = []
	q.append([start])
	until q.empty?
		path = q.shift
		r,c = path.last
		if r == fr and c == fc
			paths.append(path)
			next
		end
		q.append(path + [[r+1,c]]) if r < fr and pad[r+1][c]
		q.append(path + [[r-1,c]]) if r > fr and pad[r-1][c]
		if c < fc
			q.append(path + [[r,c+1]]) unless pad[r][c+1].nil?
		elsif c > fc
			q.append(path + [[r,c-1]]) unless pad[r][c-1].nil?
		end
	end

	rdirs = { [0,-1] => '<', [0,1] => '>', [-1,0] => '^', [1,0] => 'v' }
	return paths.map { |path| path.each_cons(2).map { |a,b| rdirs[[b[0]-a[0],b[1]-a[1]]] }.join }
end

def num_a2b(start,fin)
	num_pad = [
		['7','8','9'],
		['4','5','6'],
		['1','2','3'],
		[nil,'0','A'],
	]
	return a2b(start,fin,num_pad)
end
memoize(:num_a2b)

def dir_a2b(start,fin)
	dir_pad = [
		[nil,'^','A'],
		['<','v','>'],
	]
	return a2b(start,fin,dir_pad)
end
memoize(:dir_a2b)

def combo(segments)
	expanded = ['A']
	segments.each do |paths|
		new_expanded = []
		expanded.each do |pre|
			paths.each do |path|
				new_expanded.append(pre + path + 'A')
			end
		end
		expanded = new_expanded
	end
	return expanded
end

def solve(inputs, params, select)
	input = inputs[select]
	lines = input.lines

	#p a2b('A',0,num_pad)
	#p a2b(2,9,num_pad)
	#p a2b(2,9,num_pad)
	#p a2b(9,2,num_pad)
	#p a2b(0,1,num_pad)
	#p a2b(4,0,num_pad)
	#p a2b('<','v',dir_pad)

	puts
	ans = 0
	rows = lines
	rows.mapi { |row, r| }
	rows.eachi do |row, r|
		p 'row', row
		row = 'A' + row

		paths = row.chars.each_cons(2).map { |a,b| num_a2b(a,b) }
		paths = combo(paths)

		dpaths = paths.map { |path| combo(path.chars.each_cons(2).map { |a,b| dir_a2b(a,b) }) }.flatten
		dpaths2 = dpaths.map { |path| combo(path.chars.each_cons(2).map { |a,b| dir_a2b(a,b) }) }.flatten
		shortest = dpaths2.map(&:len).min() - 1

		num = row[/\d+/].i
		ans += num * shortest
	end

	return ans
end

# ==============================================================================
# SUBMIT
# ==============================================================================
select = 1
#select = 2

ans = solve(inputs, params, select)

real_ans = 182844
puts "[#{select}] #{ans.s.bold.yellow}".bold.blue
puts "[1] #{real_ans.s.bold.green}".bold.blue unless real_ans == 0
ans.clipboard if (ans != 0) and (select == 1)
#submit(ans) if select == 1

