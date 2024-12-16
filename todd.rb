#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

# ==============================================================================
# EXAMPLES
# ==============================================================================
# Ruby:
# - https://github.com/globalreset/advent_of_code_2023/tree/main/shared
# - https://github.com/globalreset/advent_of_code_2023/blob/main/shared/grid.rb
# Python:
# - https://github.com/mebeim/aoc/tree/master/utils
# - https://github.com/jarshwah/advent-of-code/blob/main/python/utils.py
# - https://github.com/nthistle/advent-of-code/blob/7950850b77da77c1c2a4ca15c10f793c60e7ec73/2022/day25/aoc_tools.py
# - https://github.com/mcpower/adventofcode/blob/15ae109bc882ca688665f86e4ca2ba1770495bb4/utils.py
# Other:
# - https://github.com/sbiickert/AdventOfCode2023/blob/main/Swift/AoC%202023/AoC%202023/Libraries/AoCGrid2D.swift


# ==============================================================================
# TIMER
# ==============================================================================
start_time =  Process.clock_gettime(Process::CLOCK_MONOTONIC)
at_exit {
	stop_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
	puts "Finished in #{((stop_time - start_time) * 1000).round(0)} ms"
}


# ==============================================================================
# REQUIRE
# ==============================================================================
require 'base64'
require 'digest'


# ==============================================================================
# OBJECT
# ==============================================================================
class Object
	def md5(); Digest::MD5.hexdigest(self.inspect); end
	def base64(); Base64.encode64("#{self}\n"); end
	def clipboard()
		print "\e]52;c;#{self.base64}\a"
		puts "Copied #{self.to_s.bold.yellow} to clipboard"
	end
	def sym(); return self.to_sym; end
end

# ==============================================================================
# INTEGER
# ==============================================================================
class Integer
	# Array
	def a(); self.times.to_a; end
	def map(); self.times.to_a.map{|i| yield i}; end
	def each(); self.times.each { |i| yield i }; end
	# String
	def s(); self.to_s; end
	def rjust(n); self.s.rjust(n,'0'); end
	# Math
	#def inc(n=1); self.set(n+self); end
	def sign()
		return -1 if self < 0
		return  1 if self > 0
		return 0
	end
	def half(); return self / 2; end
end

# ==============================================================================
# STRING
# ==============================================================================
class String
	def s(); self.to_s; end
	def i(); self.to_i; end
	def ascii(); self.codepoints; end
	def len(); self.size; end
	# File
	def read(); File.read(self); end
	def readlines(); File.readlines(self).map(&:chomp); end
	# Array
	def csv(); self.split(/\s*,\s*/); end
	def lines(); self.split("\n"); end
	def words(); self.split(/\s+/); end
	def splits(); self.split(/\s+/); end
	def sort(); self.split('').sort.join(''); end
	def chunks_of(n); self.chars.chunks_of(n).mjoin; end
	# Union/Intersect
	def &(string); (self.chars & string.chars).join; end
	def |(string); (self.chars | string.chars).join; end

	def scan_all(regex)
		match_data = []
		self.scan(regex) { match_data << Regexp.last_match }
		return match_data
	end

	# Just do it
	def has?(n); self.include?(n); end
	def join(_=''); return self; end

	# Regex
	def in?(string); string.include? self; end
	def d?(); self =~ /^-?\d+$/; end
	def nums(); self.scan(/-?\d+/).to_i; end
	def numbers(); self.scan(/-?\d+/).to_i; end
	def digits(); self.scan(/\d/).to_i; end
	def m(regex, n)
		m = regex.match(self)
		return nil if m.nil? or not m[n]
		return m[n]
	end
	def m1(regex); self.m(regex,1); end
	def m2(regex); self.m(regex,2); end
	def m3(regex); self.m(regex,3); end
end

# ==============================================================================
# ARRAY
# ==============================================================================
class Array
	def clean(); self.flatten.compact; end
	# New
	def Array.newa(rows,cols,value=nil); Array.new(rows) { cols.nil? ? Array.new : Array.new(cols, value) }; end
	def Array.newh(size); Array.new(size) { Hash.new }; end

	# Get
	# Huge performance slowdown for 2023-16b, but it works
	#def [](n); n.class == Array ? self.at(n[0]).at(n[1]) : self.at(n); end
	#def get(*n); self.at(n.flatten[0]).at(n.flatten[1]); end
	def get(n); self.at(n[0]).at(n[1]); end

	# Shortcuts
	def len(); self.size; end
	def rev(); self.reverse; end
	def t(); self.transpose; end
	def combs(n); self.combination(n); end
	def perms(n); self.permutation(n); end
	def has?(n); self.include?(n); end

	# To
	def i(); self.map(&:to_i); end
	def s(); self.map(&:to_s); end
	def sym(); self.map(&:to_sym); end
	def h(); Hash[self]; end
	def to_i(); self.map(&:to_i); end
	def to_s(); self.map(&:to_s); end
	def to_h(); Hash[self]; end
	def abs(); self.to_i.map(&:abs); end

	# Each
	def eachi(); self.each_with_index { |n,i| yield n, i }; end
	#def chunks(size); self.each_slice(size).to_a; end
	def chunks_of(size); self.each_slice(size).to_a; end
	# grid.xy { |row,col| run(row,col) }
	def each_xy(); self.eachi{|_,x| _.eachi{|_,y| yield x, y }} end

	# Map
	def add(other); self.map.with_index { |n,i| n + other[i] }; end
	def mapi(); self.map.with_index { |n,i| yield n, i }; end
	def mabs(); self.map(&:abs); end
	def mchars(); self.map(&:chars); end
	def mdup(); self.map(&:dup); end
	def mlen(); self.map(&:length); end
	def mlength(); self.map(&:length); end
	def mneg(); self.map{|n|-n}; end
	def msort(); self.map(&:sort); end
	def mjoin(c=''); self.map{|a| a.join(c)}; end
	def mrev(); self.map(&:reverse); end
	def mreverse(); self.map(&:reverse); end

	# Map Map
	def mmjoin(c='',r="\n"); self.map{|a| a.join(c)}.join(r); end

	# Select
	def mod(div, rem); self.select.with_index{|_,i| i%div==rem}; end

	# Rotate
	def cw(); self.transpose.mreverse; end
	def ccw(); self.mreverse.transpose; end

	# Check
	def split_at(n); [self[0...n], self[n..-1]]; end
	def split(by)
		a = []
		b = []
		self.each do |v|
			if v == by
				a.append(b) unless b.empty?
				b = []
				next
			end
			b.append(v)
		end
		a.append(b) unless b.empty?
		return a
	end

	# Reduce
	def sum(); self.clean.to_i.inject(:+) || 0; end
	def product(); self.clean.to_i.inject(:*); end
	def prod(); self.clean.to_i.inject(:*); end
	def max(); self.clean.to_i.reduce { |a,b| a>b ? a : b }; end
	def min(); self.clean.to_i.reduce { |a,b| a<b ? a : b }; end
	def lcm(); self.to_i.reduce(1,:lcm); end
	def gcd(); self.to_i.reduce(1,:gcd); end

	# Grid
	def point(x, y)
		return (x < 0 or x >= self.size or y < 0 or y >= self[x].size) ? nil : self[x][y]
	end

	# Point
	def x; self[0]; end
	def y; self[1]; end
	def move(dir); [self[0]+dir[0], self[1]+dir[1]]; end
	def up   ; self.move(Dir.N); end
	def right; self.move(Dir.E); end
	def down ; self.move(Dir.S); end
	def left ; self.move(Dir.W); end

	# Direction
	def backwards(); self.map{|n|-n}; end

	# Regex
	# REVISIT: Do I need this?
	def match_lr(i, re)
		return nil if not self[i] =~ re
		left, right = i, i
		left -= 1 while left >= 0 and self[left] =~ re
		right += 1 while right < self.size and self[right] =~ re
		return self[(left+1)..(right-1)]
	end
end

class Hash
	# REVISIT:
	# https://github.com/globalreset/advent_of_code_2023/blob/899228feda60575f56b76e0335b4c7a22885df63/shared/util.rb#L2

	# New
	def Hash.newa(); Hash.new { |hash, key| hash[key] = [] }; end
	def Hash.newh(); Hash.new { |hash, key| hash[key] = {} }; end
end

class Range
	def a(); self.to_a; end
	def join(c=''); self.to_a.join(c); end
end

class Enumerator
	def a(); self.to_a; end
end

# ==============================================================================
# SET
# ==============================================================================
class Set
	def has?(n); self.include?(n); end
	def len(); self.size; end

	def append(n); self.add(n); end
	def shift()
		result = self.first
		self.delete(result)
		return result
	end

end

# ==============================================================================
# GRID
# ==============================================================================
class NotGridError < StandardError
	def initialize(msg="Array is not a grid"); super; end
end

class Array
	# Info
	def grid?(); self.map(&:size).uniq.size == 1; end
	def width(); self.mlen.max; end
	def height(); self.size; end

	def gindex(s)
		index = []
		self.each_with_index do |row,r|
			row.each_with_index do |col,c|
				index.append([r,c]) if s == col
			end
		end
		return index
	end

	# Get
	def diags
		d = Hash.new { |hash, key| hash[key] = [] }
		u = Hash.new { |hash, key| hash[key] = [] }
		h = self.height
		w = self.width
		h.times.each do |r|
			w.times.each do |c|
				d[r-c].append(self[r][c])
				u[r-c].append(self[h-r-1][c])
			end
		end
		return d.values + u.values
	end

	# Fill
	def ljust(fill=' '); self.map { |s| s + Array.new(self.width-s.len,fill) }; end
	def rjust(fill=' '); self.map { |s| Array.new(self.width-s.len,fill) + s }; end
	def border(size=1, fill=nil)
		raise NotGridError, "contains row sizes of: #{self.mlen.uniq.sort.join(',')}" unless self.grid?
		new = Array.new(size) { Array.new(self.width,fill) } + self + Array.new(size) { Array.new(self.width,fill) }
		new = new.map { |row| Array.new(size,fill) + row + Array.new(size,fill) }
		return new
	end
end

# ==============================================================================
# DIRECTION
# ==============================================================================
class Dir
	N = [-1, 0]
	S = [ 1, 0]
	E = [ 0, 1]
	W = [ 0,-1]

	DIRS = {
		'N' => N,
		'E' => E,
		'S' => S,
		'W' => W,
		'U' => N,
		'R' => E,
		'D' => S,
		'L' => W,
		'^' => N,
		'>' => E,
		'v' => S,
		'<' => W,
	}

	def Dir.U    ; N; end
	def Dir.D    ; S; end
	def Dir.R    ; E; end
	def Dir.L    ; W; end
	def Dir.up   ; N; end
	def Dir.down ; S; end
	def Dir.right; E; end
	def Dir.left ; W; end
	def Dir.N    ; N; end
	def Dir.S    ; S; end
	def Dir.E    ; E; end
	def Dir.W    ; W; end
	def Dir.dirs ; Dir::DIRS; end

	def Dir.D9(r=0,c=0)
		return [
			[r-1,c-1],[r-1,c  ],[r-1,c+1],
			[r  ,c-1],[r  ,c  ],[r  ,c+1],
			[r+1,c-1],[r+1,c  ],[r+1,c+1],
		]
	end
	def Dir.D8(r=0,c=0)
		return [
			[r-1,c-1],[r-1,c  ],[r-1,c+1],
			[r  ,c-1],          [r  ,c+1],
			[r+1,c-1],[r+1,c  ],[r+1,c+1],
		]
	end

	def Dir.D5(r=0,c=0)
		return [
			          [r-1,c  ],
			[r  ,c-1],[r  ,c  ],[r  ,c+1],
			          [r+1,c  ],
		]
	end
	def Dir.D4(r=0,c=0)
		return [
			          [r-1,c  ],
			[r  ,c-1],          [r  ,c+1],
			          [r+1,c  ],
		]
	end

	def Dir.X5(r=0,c=0)
		return [
			[r-1,c-1],          [r-1,c+1],
			          [r  ,c  ],          
			[r+1,c-1],          [r+1,c+1],
		]
	end
	def Dir.X4(r=0,c=0)
		return [
			[r-1,c-1],          [r-1,c+1],
			
			[r+1,c-1],          [r+1,c+1],
		]
	end
end


# ==============================================================================
# FUNCTIONS
# ==============================================================================
def p(string, *inputs)
	return unless $DEBUG
	file, line, _ = caller_locations.first.to_s.split(':')
	#from = "[#{File.basename(file)}:#{line}]".ansi('38;5;8')
	from = "[#{File.basename(file)}:".ansi('38;5;8')
	from += line.cyan + ']'.ansi('38;5;8')
	if inputs.size > 0 then
		string = string.to_s.green
	else
		string = string.inspect
	end
	inputs.map!(&:inspect)
	inputs.map! { |str| str.size <= 2 ? str : str[0].bold.red + str[1..-2] + str[-1].bold.red }
	puts "#{from} #{string} #{inputs.join(' ')}"
end
$DEBUG = true

def e(string)
	file, line, _ = caller_locations.first.to_s.split(':')
	from = "[#{File.basename(file)}:#{line}]".ansi('38;5;8')
	puts "#{from} #{"ERROR:".bold.red} #{string.to_s}"
end

#def memoize(name, *args)
#	@cache ||= {}
#	@cache[name] ||= {}
#	orig_name = "orig_#{name}".to_sym
#	eval "alias #{orig_name} #{name}"
#	send(:define_method, name) do |*args|
#		return @cache[name][*args] if @cache[name][*args]
#		@cache[name][*args] ||= method(orig_name).call *args
#	end
#end
def memoize(method_name)
	original_method = method(method_name)
	cache = {}
	define_singleton_method(method_name) do |*args|
		cache[args] ||= original_method.call(*args)
	end
end

# Cantor pairing function
# https://en.wikipedia.org/wiki/Pairing_function#Cantor_pairing_function
def pair(x, y)
	return (x + y) * (x + y + 1) / 2 + y
end
def unpair(z)
	w = ((Math.sqrt(8 * z + 1) - 1) / 2).floor
	t = (w**2 + w) / 2
	y = z - t
	x = w - y
	return [x, y]
end

# ==============================================================================
# OTHER
# ==============================================================================
# Colors
class String
	def ansi(n); "\e[#{n}m#{self}\e[0m"; end
	def bold();    ansi( 1); end
	def black();   ansi(30); end
	def red();     ansi(31); end
	def green();   ansi(32); end
	def yellow();  ansi(33); end
	def blue();    ansi(34); end
	def magenta(); ansi(35); end
	def cyan();    ansi(36); end
	def white();   ansi(37); end
end

def input_stats(input_txt)
	lines = input_txt.lines
	puts "#{lines.len} lines".bold.blue
	words_per_line = input_txt.lines.map { |line| line.words.len }
	puts "#{words_per_line.min}-#{words_per_line.max} words per line".bold.blue

	# Grid
	grid = lines.mchars
	height, width = grid.height, grid.width if grid.grid?
	puts "#{height}x#{width} grid".bold.blue if grid.grid?
end

# ==============================================================================
# SUBMIT
# ==============================================================================
def submit(answer, level = nil)

	puts
	puts "Submitting answer #{answer.s.bold.yellow}..."
	script_path = File.expand_path($0)
	year, day, script_name = script_path.split('/')[-3..-1]

	# Strip leading 0 in day
	day = day.i.s

	# Get level
	if level.nil? then
		if script_name == 'a.rb' then
			level = 1
		elsif script_name == 'b.rb' then
			level = 2
		else
			raise "Invalid script name #{script_name}"
		end
	end

	session_path = File.dirname(File.expand_path(__FILE__))
	session = File.read("#{session_path}/.session.txt").strip

	url = "https://adventofcode.com/#{year}/day/#{day}/answer"
	data = {'level' => level, 'answer' => answer}

	require 'net/http'
	require 'uri'

	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	request = Net::HTTP::Post.new(uri.path)
	request['Cookie'] = "session=#{session}"
	request.set_form_data(data)
	response = http.request(request)

	# Write response body to a file
	ts = Time.now.strftime("%Y%m%d-%H%M%S")
	response_txt = "#{File.dirname(script_path)}/.response_#{ts}.txt"
	File.write(response_txt, "#{url}\n#{data}\n\n#{response.body}")

	puts
	puts "Response code: #{response.code.s.bold.blue}"
	main = response.body.match(/<main>\n(.*)^<\/main>/m)[1]
	puts main
end

