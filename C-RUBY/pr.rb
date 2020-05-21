# class Ruby
#   @attr
#   @foo
#   @bar
#
#   attr_reader :foo, :bar
#
#   attr_accessor :foo
#
#   def say
#     puts "Hello"
#   end
#
#   protected
#   def for_my_grandchildren
#     puts "I got 99 problems"
#   end
#
#   private
#   def lol
#     puts "Kek"
#   end
# end
#
# r = Ruby.new
# r.say
# r.foo = 2
# puts r.foo
# #puts r.for_my_grandchildren
# #puts r.lol
#
# class MyRational
#   def initialize(num, den=1)
#     if den == 0
#       raise "MyRational recieved an inappropriate argument"
#     elsif den < 0
#       @num = - num
#       @den = - den
#     else
#       @num = num
#       @den = den
#     end
#     reduce #i.e. self.reduce() but private
#   end
#
#   def to_s
#     ans = @num.to_s
#     if @den != 1
#       ans += "/"
#       ans += @den.to_s
#     end
#     ans
#   end
#
#   def to_s2
#     dens = ""
#     dens = "/" + @den.to_s if @den != 1
#     @num.to_s + dens
#   end
#
#   def to_s3
#     "#{@num}#{if @den==1 then "" else "/" + @den.to_s end}"
#   end
#
#   def add! r # mutate self in-place
#     a = r.num
#     b = r.den
#     c = @num
#     d = @den
#     @num = (a * d) + (b * c)
#     @den = b * d
#     reduce
#     self
#   end
#
#   def + r
#     ans = MyRational.new(@num, @den)
#     ans.add! r
#     ans
#   end
#
#   def gcd(x,y)
#     if x == y
#       x
#     elsif x < y
#       gcd(x, y-x)
#     else
#       gcd(y, x)
#     end
#   end
#
#
#   def reduce
#     if @num == 0
#       @den = 1
#     else
#       d = gcd(@num.abs, @den)
#       @num = @num /d
#       @den = @den/d
#     end
#   end
# end
#
#
# # Arrays
# def arrays
#   a = [12, 17, 22]
#
#   a[2]
#   a[5]
#   a[-1]
#   a[-50]
#   a.size
#   a[4]="hi"
#   a + [true,false]
#   #Remove duplicates - i.e. 2
#   c = [3,2,5] | [2,1,7]
#
#   l = if a.size < 5 then a.size + 42 else 42
#   #Array l length
#   aa = Array.new(l)
#   #Array l length initialized to 0
#   aa1 = Array.new(l){0}
#   aa2 = Array.new(l)
#
#   a.push 5
#   # Remove and return the one element from the right side
#   a.pop
#
#   a.push 11
#   # Remove and return the one element from the left side
#   a.shift
#
#   # Add one element to the left side
#   a.unshift 22
#
#   # Alias
#   e = a
#
#   #Slicing
#   a[1,2,3,4,5,6,7,8]
#   # a[3,4,5]
#   a[2,4]
#   # Map to each element
#   [1,2,5,7].each {|i| puts(i*i)}
#
# end
#
#   # Hashes
# def hashes_ranges
#   h = {}
#   h["a"] = "Found A"
#   h[false] = "Found False"
#   h
#   h[42]
#   h.keys
#   h.values
#   h_ = {"SML"=>1, "Racket"=>2, "Ruby"=>3}
#   h_["SML"]
#   h_.size
#   h_each {|k,v| puts k; puts ": "; puts v}
#
#   # Ranges
#   1..100000
#   (1..100).inject {|acc,elt| acc + elt} # Reduce-like
# end

# # Procs
# def procs
#   a = [3, 10, 12, 15]
#   b = a.map {|x| x + 1}
#   i = b.count {|x| x >= 6}
#   # c = a.map {|x| {|y| x >= y}} # array of functions, won't work out
#   c = a.map {|x| (lambda {|y| x>= y})}
#   c
#   c.size
#   c[2] # each element is an instance of the proc class
#   # c[2].call - error
#   c[2].call(7)
#   c.count {|x| x.call(3)}
# end
#
#
# # Subclassing
# class Point
#   attr_accessor :x, :y
#
#   def initiailize(a,b)
#     @x = a
#     @y = b
#   end
#
#   def distFromOrigin
#     Math.sqrt(@x * @x + @y * @y) #uses instance variables
#   end
#
#   def distFromOirigin2
#     Math.sqrt(x * x + y * y) #uses getter methods, 4 calls
#   end
# end
#
# class ColorPoint < ColorPoint
#   attr_accessor :color
#   def initialize(x, y, c="clear")
#     super(x,y)
#     @color=c
#   end
# end
#
# class ThreeDPoint < Point
#   attr_accessor :z
#
#   def initialize(x,y,z)
#     super(x,y)
#     @z = z
#   end
#   def distFromOrigin
#     d=super
#     Math.sqrt(d*d+@z*@z)
#   end
#   def distFromOirigin2
#     d=super
#     Math.sqrt(d*d+z*z)
#   end
# end
#
# class PolarPoint < Point
#   def initialize(r, theta)
#     @r = r
#     @theta=thata
#   end
#   def x
#     @r*Math.cos(@theta)
#   end
#   def y
#     @r * Math.sin(@theta)
#   end
#
#   def x=
#     b=y
#     @theta=Math.atan(b/a)
#     @r=Math.sqrt(a*a+b*b)
#     self
#   end
#
#   def y= b
#     a=y
#     @theta=Math.atan(b/a)
#     @r=Math.sqrt(a*a+b*b)
#     self
#   end
#
#   def distFromOrigin
#     @r
#   end
#
# end

class A
  def even x
    puts "in even A"
    if x==0 then true else odd(x-1) end
  end
  def odd x
    puts "in odd A"
    if x==0 then false else even(x-1) end
  end
end

a1 = A.new.odd 7
puts "a1 is " + a1.to_s + "\n\n"

class B < A
  def even x # changes B's odd too (helps)
    puts "in even B"
    x % 2 == 0
  end
end

class C < A
  def even x
    puts "in even C" # changes C's odd too (hurts)
    false
  end
end

a2 = B.new.odd 7
puts "a2 is " + a2.to_s + "\n\n"

a3 = C.new.odd 7
puts "a3 is " + a3.to_s + "\n\n"

# Blocks
3.times {puts "hello"}
[4,6,7].each {puts "hi"}
[6,7,8].each {|x| puts x}
i=7
[4,7,8,9].each {|x| if x > 7 then puts i*x end}


# Map (map, collect) with blocks
a = Array.new(10) {|i| 4*(i+1)}
b = a.each {|x| puts (x*2)}
c = a.map {|x| puts (x*32)}
d = a.collect {|x| puts (x*32)}
puts b.size
puts c.size
puts c[-1]

puts a.any? {|x| x > 7}
puts a.all?
puts a.all? {|x| x > -7}
(a + [false]).all? #False
(a + [nill]).all? #False
(a + ["hi"]).all? #True

# Reduce (inject) with Blocks
a.inject(0) {|acc, elt| acc+elt} #intial accumulator is 0
a.inject {|acc, elt| acc+elt} #intiail accumulator is the first element of array

# Filter (select) with blocks
a.select {|x| x > 7}
a.select {|x| x > 7 && x < 18}

def t i
  (0..i).each do |j|
    print "  " * j
    (j..i).each {|k| print k; print "  "}
    print "\n"
  end
end

t()

#Using Blocks
class Foo
  def intiailize(max)
    @max = max
  end

  def silly a
    (yield a) + (yield 42)
    # x.silly(5) {|b| b*2}
    # 94 = (5 + 42) * 2
  end

  def count base
    if base > @max
      raise "reached max"
    elsif yield base
      1
    else
      1 + (count(base+1) {|i| yield i})
    end
  end
  # f.count(10) {|i| (i*i) == (34*i)}
end
