
planet_cords_arr = []
empty_row_list = []
planet_column_list = []
col_len = 0

planet_counter = 0

IO.readlines("./main.txt").map(&:chomp).each_with_index do |line,index1|
#get x cords of empty row
if !line.include?("#")
empty_row_list.append(index1)
end
col_len+=1

  #creating planet_cords_arr
  line.chars.each_with_index do |char,index2|
    if char == '#'
      planet_cords_arr.push([index1,index2])

      planet_column_list.append(index2)
      planet_counter += 1
    end
end
end

planet_column_list = planet_column_list.uniq
empty_planet_column_list = Array.new(col_len).each_with_index.map do |i,ind|
i = ind
end
empty_planet_column_list = empty_planet_column_list - planet_column_list

#p planet_cords_arr

planet_combinations_arr = planet_cords_arr.combination(2).to_a



p empty_row_list
p empty_planet_column_list

sum_distance = 0
#manhattan distance
planet_combinations_arr.each do |pair|
  expand_count = 0


    x1 = pair[0][0]
    y1 = pair[0][1]

    x2 = pair[1][0]
    y2 = pair[1][1]

    empty_row_list.each do|i|
      if (x1 < i && i < x2) || (x2 < i && i < x1)
        expand_count += 1
      end
    end

    empty_planet_column_list.each do|i|
      if (y1 < i && i < y2) || (y2 < i && i < y1)
          expand_count += 1
      end
    end




  distance = (pair[0][0] - pair[1][0]).abs + (pair[0][1] - pair[1][1]).abs
  sum_distance += distance + expand_count

  puts "pair: #{pair}, distance: #{distance}, expand: #{expand_count}, total distance: #{distance + expand_count}"
end


p sum_distance
