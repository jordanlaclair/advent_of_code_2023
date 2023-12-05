file = File.read('./main.txt').split("\n")
pile_of_cards_total = 0




file.each do |line|
line_without_card  = line.split(": ")[1]
winning_numbers = line_without_card.split(" |")[0].split(" ")
numbers_you_have = line_without_card.split("| ")[1].split(" ")
line_winning_match_count = 0


winning_numbers.each do |winning_number|
  numbers_you_have.each do |number|
    if number.to_i == winning_number.to_i
      line_winning_match_count += 1
    end
  end
end

if line_winning_match_count > 0
  pile_of_cards_total += 2.pow(line_winning_match_count-1)
end

end

puts pile_of_cards_total
