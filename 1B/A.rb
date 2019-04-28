require 'pp'

def ppd(*arg)
  if $DEBUG
    arg.each do |e|
      PP.pp(e, STDERR)
    end
  end
end

def putsd(*arg)
  if $DEBUG
    STDERR.puts(*arg)
  end
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

def puts_sync(str)
  puts str
  STDOUT.flush
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  num, q = ris
  mans = []
  num.times do
    x, y, d = rss
    mans << [x.to_i, y.to_i, d]
  end

  ans_x = -1
  ans_y = -1

  dir = mans.select do |e|
    e[2] == "W"
  end
  min_w = dir.min_by do |e|
    e[0]
  end
  min_w = min_w[0] if min_w

  dir = mans.select do |e|
    e[2] == "E"
  end
  max_e = dir.max_by do |e|
    e[0]
  end
  max_e = max_e[0] if max_e

ppd min_w, max_e
  ans_x = 
    if !min_w && max_e
      max_e + 1
    elsif min_w && !max_e
      min_w - 1
    elsif !min_w && !max_e
      0
    else
      if min_w <= max_e
        0
      else
        max_e + 1
      end
    end
ppd ans_x

  dir = mans.select do |e|
    e[2] == "S"
  end
  min_s = dir.min_by do |e|
    e[1]
  end
  min_s = min_s[1] if min_s

  dir = mans.select do |e|
    e[2] == "N"
  end
  max_n = dir.max_by do |e|
    e[1]
  end
  max_n = max_n[1] if max_n

ppd "--"
ppd min_s, max_n
  ans_y = 
    if !min_s && max_n
      max_n + 1
    elsif min_s && !max_n
      min_s - 1
    elsif !min_s && !max_n
      0
    else
      if min_s <= max_n
        0
      else
        max_n + 1
      end
    end
ppd ans_y

  puts "Case ##{case_index}: #{ans_x} #{ans_y}"

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
