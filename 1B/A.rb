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

def solve(dirs, q)
  range0 = [0, q, 0]
  range1 = [0, q, 0]

  dirs.sort_by! do |e|
    e[0]
  end

  dirs.each do |e|
    if e[1] == "-"
      range0 = [range0[0], e[0]-1, range0[2]+1]
      if e[0] 
    end
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

  dirs = mans.select do |e|
    e[2] == "W" || e[2] == "E"
  end
  dirs.map! do |e|
    [e[0], e[2] == "W" ? "-" : "+"]
  end
  ans_x = solve(dirs)









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
