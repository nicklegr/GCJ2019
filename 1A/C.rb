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

def common_suffix(a, b, already)
  a = a.reverse
  b = b.reverse

  min = [a.size, b.size].min

  for i in 1..min
    if a[0, i] == b[0, i]
      suf = a[0, i].reverse
      if !already.key?(suf)
        return suf
      end
    end
  end

  nil
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  words = rws(n)
ppd words

  max = 0
  words.permutation(n) do |arr|
    last = nil
    count = 0
    already = {}

    arr.each do |e|
      if !last
        last = e
        next
      end

      suf = common_suffix(last, e, already)
      if suf
        count += 2
        already[suf] = 1
        last = nil
      else
        last = e
      end
    end

    if count > max
      max = count
    end
  end

  puts "Case ##{case_index}: #{max}"

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
