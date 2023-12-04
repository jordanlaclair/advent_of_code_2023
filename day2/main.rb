
def valid_red_count(count)
  count <=12
end
def valid_green_count(count)
  count <=13
end
def valid_blue_count(count)
  count <=14
end


def validColorCount(color, count)
  if color == "red" and valid_red_count(count)
    true
  elsif color == "green" and valid_green_count(count)
    true
  elsif color == "blue" and valid_blue_count(count)
    true
  else
    false
  end
end



file = File.read('./main.txt').split("\n")

allowed_games_ids_sum = 0


#returns new array for which elements evaulate to true
allowed_games = file.each do |line|

  game_id = line.split(":")[0].split(" ")[1].to_i
  validColorCount = true
  validLine = true

  line.split(": ")[1].to_s.split("; ").each do |set|


    set_of_combos = set.split(", ")

    set_of_combos.each do |combo|
      parse_combo = combo.split()
      #puts parse_combo.join("")
      count = parse_combo[0].to_i
      color = parse_combo[1]


      if !validColorCount(color,count)
        validLine = false
      end
    end
  end

  if validLine
    allowed_games_ids_sum += game_id
  end

  #puts "#{game}: red count: #{red_count} green count: #{green_count} blue count: #{blue_count}"

end



puts allowed_games_ids_sum
