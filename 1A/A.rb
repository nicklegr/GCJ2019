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

def solve(x, y, map)
# ppd x, y
  if map.size == 1
    $route << [map[0][0], map[0][1]]
    return true
  end

  nmap = map.dup
  nmap.delete([x, y])
  $route << [x, y]

  nmap.each do |nx, ny|
    if x == nx || y == ny || x - y == nx - ny || x + y == nx + ny
      next
    end

    if solve(nx, ny, nmap)
      return true
    end
  end

  $route.pop
  return false
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  r, c = ris

  $route = []
  ok = false
  for y in 0...r
    for x in 0...c
      break if ok

      map = []
      for y in 0...r
        for x in 0...c
          map << [x, y]
        end
      end

      if solve(x, y, map)
        ok = true
      end
    end
  end

  puts "Case ##{case_index}: #{ok ? "POSSIBLE" : "IMPOSSIBLE"}"
  if ok
    $route.each do |x1, y1|
      puts "#{x1+1} #{y1+1}"
    end
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
