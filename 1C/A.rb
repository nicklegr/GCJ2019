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
  a = ri
  prgs = rws(a)
# pp prgs

  prgs.map! do |e|
    cnt = (120 / e.size)
    e * cnt
  end
# pp prgs

  prgs.each do |e|
    raise if e.size != 120
  end

  win = []
  prgs.size.times do
    win << false
  end

  ans = ""
  for i in 0...120
    hands = {}

    prgs.each do |e|
      hands[e[i]] = 1
    end

    mine = nil

    hands = hands.keys
    if hands.size == 3
      ans = "IMPOSSIBLE"
      break
    elsif hands.size == 2
      case hands.sort.join("")
      when "PR"
        mine = "P"
      when "PS"
        mine = "S"
      when "RS"
        mine = "R"
      else
        raise
      end
    else
      raise if hands.size != 1
      case hands[0]
      when "R"
        mine = "P"
      when "P"
        mine = "S"
      when "S"
        mine = "R"
      else
        raise
      end
    end
    ans += mine

    prgs.each_with_index do |e, i1|
      case e[i]
      when "R"
        win[i1] = true if mine == "P"
      when "P"
        win[i1] = true if mine == "S"
      when "S"
        win[i1] = true if mine == "R"
      else
        raise
      end
    end

    break if win.all?
  end
ppd win

  if win.all?
    puts "Case ##{case_index}: #{ans}"
  else
    puts "Case ##{case_index}: IMPOSSIBLE"
  end

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
