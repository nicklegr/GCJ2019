require 'pp'
require "bigdecimal/math"

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

  # >= Ruby 2.5
  def self.sqrt(v)
    BigMath::sqrt(BigDecimal(v, 110), 110).to_i
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
      prime = Integer.sqrt(prime)
    end

    primes[prime] = 1
  end

  # 最初と最後の文字に対応するprimeはまだ分かってない可能性がある
  prime = list[0] / (list[0].gcd(list[1]))
  primes[prime] = 1 if prime != 1

  prime = list[-1] / (list[-2].gcd(list[-1]))
  primes[prime] = 1 if prime != 1

  # # なぜか26個揃わない場合がある
  # extra = []
  # list.each do |e|
  #   primes.keys.each do |e1|
  #     if e % e1 == 0
  #       v = e / e1
  #       extra << v if (v != 1 && v <= n)
  #     end
  #   end
  # end
  # primes = (primes.keys + extra).uniq

  primes = primes.keys

ppd primes.size
ppd primes.sort
  # raise if primes.size != 26

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
      factor = Integer.sqrt(factor)
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
    factor = Integer.sqrt(factor)
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

__END__

a * b = X1
b * c = X2
c * d = X3
...
x * y = X24
y * z = X25

gcd(X1, X2) = b
gcd(X2, X3) = c
...
gcd(X24, X25) = y
a = X1 / b
z = X25 / y

同じ文字が2文字連続 aa
a * a = X1
if sqrt(X1) is int
  a = sqrt(X1)

いや、
a * a = X1
a * b = X2
gcd(X1, X2) = a
特に例外処理不要

同じ文字が3文字連続 aaa
a * a = X1
a * a = X2
この場合は例外でa = sqrt(X1)

aaab
a * a = X1
a * a = X2
a * b = X3
a = sqrt(X1)
gcd(X2, X3) = a


平文復元
X1をa-zで割ってみる。j,kで割り切れたとする
X2をa-zで割ってみる。k,lで割り切れたとする
この場合、平文はjk(次はl)

X1 == X2の場合、どちらもj,kで割り切れたとする
この場合、jkjかkjkかわからない
X2 != X3なら、上記ロジックでj*かk*かわかる。これでjkjかkjkのどちらか確定する
同じ積が3つ以上連続する場合もある

いや、X1 == X2の時点で同じ文字連続が確定するし、
その場合は割りきれる数はaのみ。気にしなくていいのかな


SUBDERMATOGLYPHICFJKNQVWXZ
SSSUBDERMATOGLYPHICFJKNQVWXZ
