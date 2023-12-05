file = File.read('./main2.txt').split("\n")
file2 = File.open("./main2.txt", 'r')


def parseLine(line)
  line_without_card  = line.split(": ")[1]
  winning_numbers = line_without_card.split(" |")[0].split(" ")
  numbers_you_have = line_without_card.split("| ")[1].split(" ")
  match_count = 0

  winning_numbers.each do |winning_number|
    numbers_you_have.each do |number|
      if number.to_i == winning_number.to_i
        match_count += 1
      end
    end
  end

  return match_count
end


def get_next_cards(start_line, max, file)
  list = []
    # Open the file in read mode
    # Move to the specified starting line
    (start_line+1).times { file.gets }
    # Read and print lines until the end of the file

    max.times do |i|
      if file.eof?
        break
      end

      line = file.gets
      list.append(line.chomp!)
  end
  return list
end



n = 215
arr = Array.new(n,1)
copies = []


file.each_with_index do |line, index|

match_count = parseLine(line)
temp =[]
if match_count > 0
  file2 = File.open("./main2.txt", 'r')
  list = get_next_cards(index, match_count, file2)

  list.each do |line2|
    gameNumber = line2.split(":")[0].split("Card ")[1].strip.to_i

    gameWinCount = parseLine(line2).to_i
    temp.append(gameNumber)

    begin
    rescue Errno::ENOENT
      puts "File not found: #{file_path}"
    ensure
      # Close the file
      file2&.close
    end
  end
  else

end
copies.append(0)
end



for i in (0...n).to_a.reverse
  copies[i].each do |j|
    arr[i] += arr[j]
  end
end

total = arr.sum
p total
