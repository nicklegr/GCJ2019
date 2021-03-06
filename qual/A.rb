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
  v = ri

  a = 0
  b = 0
  if (v & 1) == 1
    a = (v-1) / 2 + 1
    b = (v-1) / 2
  else
    a = v / 2
    b = v / 2
  end

  a = a.to_s
  b = b.to_s

  if a.size != b.size
    # maybe not contains "4"
    puts "Case ##{case_index}: #{a} #{b}"
  else
    for i in 0 ... a.size
      while a[i] == "4" || b[i] == "4"
        a[i] = (a[i].to_i + 1).to_s
        b[i] = (b[i].to_i - 1).to_s
      end
    end
    puts "Case ##{case_index}: #{a} #{b}"
  end

  raise v.to_s if a.to_i + b.to_i != v

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

__END__

84
-> 42 + 42
-> 32 + 52

85
-> 43 + 42
-> 33 + 52

19
-> 10 + 9

199
-> 100 + 99

7
-> 4 + 3

9
-> 5 + 4
