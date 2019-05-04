require 'pp'

def ppd(*arg)
  arg.each do |e|
    PP.pp(e, STDERR)
  end
end

def putsd(*arg)
  STDERR.puts(*arg)
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
t, f = ris

t.times do
  tbl = {}
  prefix = ""
  check_index = []

  j = 1
  loop do
    check_index << j
    j += 5
    break if j > 595
  end
# ppd check_index

  q_count = 0

  4.times do
    check_index.each do |index|
      i = index + prefix.size
      puts_sync(i)

      res = rs
      if tbl.key?(prefix + res)
        tbl[prefix + res] << index
      else
        tbl[prefix + res] = [ index ]
      end

      q_count += 1
    end

# ppd tbl

    # 少ない文字
    less = tbl.min_by do |e|
      e[1].size
    end
    # ppd less

    tbl = {}
    prefix += less[0][-1, 1]
    check_index = less[1]
  end

# ppd prefix
  left = %w|A B C D E| - prefix.chars.to_a

  ans = prefix[0, 3] + left[0] + prefix[3, 1]

  # 余った分
  (f - q_count).times do
    puts_sync(1)
    rs
  end

  # answer
  puts_sync(ans)
  res = rs
  if res == "N"
    exit(1)
  end
end
