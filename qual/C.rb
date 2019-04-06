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
  n, l = ris
  list = ris

  primes = {}

  list.each_cons(2) do |pair|
    prime = pair[0].gcd(pair[1])

    # 同じ文字が2文字連続
    if prime == pair[0]
      prime = Math.sqrt(prime).to_i
    end

    primes[prime] = 1
  end

  # 最初と最後の文字に対応するprimeはまだ分かってない可能性がある
  prime = list[0] / (list[0].gcd(list[1]))
  primes[prime] = 1 if prime != 1

  prime = list[-1] / (list[-2].gcd(list[-1]))
  primes[prime] = 1 if prime != 1

  # なぜか26個揃わない場合がある
  extra = []
  list.each do |e|
    primes.keys.each do |e1|
      if e % e1 == 0
        v = e / e1
        extra << v if (v != 1 && v <= n)
      end
    end
  end

  primes = (primes.keys + extra).uniq

ppd primes.size
ppd primes.sort
  raise if primes.size != 26

  tbl = {}
  ("A".."Z").zip(primes.sort).each do |p|
    tbl[p[0]] = p[1]
  end
ppd tbl

  answer = ""
  list.each_cons(2) do |a, b|
putsd a,b
    factor = a.gcd(b)

    if factor == a
      # 同じ文字が2文字連続
      factor = Math.sqrt(factor).to_i
      answer += tbl.rassoc(factor)[0]
    else
      answer += tbl.rassoc(a / factor)[0]
    end
putsd answer
  end

  # 最後の2文字
  a = list[-2]
  b = list[-1]
  factor = a.gcd(b)

  if factor == a
    # 同じ文字が2文字連続
    factor = Math.sqrt(factor).to_i
    answer += tbl.rassoc(factor)[0] * 2
  else
    answer += tbl.rassoc(factor)[0]
    answer += tbl.rassoc(b / factor)[0]
  end

  puts "Case ##{case_index}: #{answer}"

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
