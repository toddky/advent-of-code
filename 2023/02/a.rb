#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = 'input.txt'
#file = 'example.txt'
W = file.readlines.map(&:words)
ans = 0

W.map{|w|w[2..-1].join.split(';').split(',')}.eachi do |w,i|
	valid = i+1
	w.flatten.each do |game|
		game.split(',').each do |a|
			if a['green'] and a.i > 13 then
				valid = 0
			elsif a['blue'] and a.i > 14 then
				valid = 0
			elsif a['red'] and a.i > 12 then
				valid = 0
			end
		end
	end
	ans += valid
end

puts ans.s.bold.yellow
puts 2679.s.bold.green
ans.clipboard unless ans == 0

