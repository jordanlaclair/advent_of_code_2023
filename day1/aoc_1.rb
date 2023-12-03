file = File.read('aoc_1.txt').split
temp_arr = Array.new

 numbers_hash = {
  "one": "1",
  "two": "2",
  "three": "3",
  "four": "4",
  "five": "5",
  "six": "6",
  "seven": "7",
  "eight": "8",
  "nine": "9",
}



def parseLine(line, numbers_hash)
  temp = ""
  line.chars.each do |c|
      temp+=c
      numbers_hash.each do |key,value|
        if temp.include?(key.to_s)
          char = "#{key[-1]}"
          temp = temp.sub(key.to_s,numbers_hash[key]) + char
        end
      end
  end


return temp

end


temp_arr = file.map! { |line| parseLine(line, numbers_hash) }



numbers_arr = temp_arr.map { |line| line.delete('^0-9') }

puts numbers_arr



total = 0
subTotal = 0
for i in numbers_arr

  if i.size == 0
    next
  end

  firstInt = i[0].to_i
  lastInt = i[-1].to_i

  if !firstInt.respond_to?(:to_s)
    firstInt = 0
  end

  if !lastInt.respond_to?(:to_s)
    lastInt = 0
  end
  total = "#{firstInt}#{lastInt}".to_i
  #puts total
  subTotal += total
end

puts ""
puts subTotal
