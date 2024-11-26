#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = 'input.txt'
#file = 'example.txt'
W = file.readlines.map(&:words)
ans = 0

W.map{|w|w[2..-1].join.split(';').split(',')}.eachi do |w,i|
	red = 0
	green = 0
	blue = 0
	w.flatten.each do |game|
		game.split(',').each do |a|
			if a['green'] and a.i > green then
				green = a.i
			elsif a['blue'] and a.i > blue then
				blue = a.i
			elsif a['red'] and a.i > red then
				red = a.i
			end
		end
	end
	ans += red * green * blue
end

puts ans.s.bold.yellow
puts 77607.s.bold.green
ans.clipboard unless ans == 0

