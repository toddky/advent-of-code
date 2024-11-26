#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = 'example.txt'
#file = 'input.txt'
L = file.readlines
P = file.readlines.split('')
W = file.readlines.map(&:words)
N = file.readlines.map(&:numbers)
A = file.readlines.map(&:numbers).map(&:abs)
C = file.readlines.mchars
CSV = file.readlines.map{|line| line.split(',')}
G = file.readlines.mchars
rows, cols = G.rows, G.cols unless G.rows == 0
ans = 0


L.mapi { |line, i| line }
L.eachi do |line, i|
end


puts ans.s.bold.yellow
puts 0.s.bold.green
ans.clipboard unless ans == 0

