input = ""
File.readlines("./main.txt").map(&:chomp).each do |line|
  input += line
end

total = 0

input.split(",").each do |str|
  curr = 0
  str.chars.each do|char|
    curr += char.ord
    curr *= 17
    curr %= 256
  end
  total += curr
end

puts total

