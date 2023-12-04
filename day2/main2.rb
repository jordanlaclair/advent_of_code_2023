def setColorMaxCount(count,color, colorsObject)
  obj = colorsObject.clone

  if color == "red"
    if count > obj[:red]
      obj[:red] = count
    end
  elsif color == "green"
    if count > obj[:green]
      obj[:green] = count
    end
  elsif color == "blue"
    if count > obj[:blue]
      obj[:blue] = count
    end
  end

  return obj
end



file = File.read('./main2.txt').split("\n")

colorsProductSum = 0
allowed_games = file.each do |line|

  colorsMaxes = {red: 0, green: 0, blue: 0}
  colorsProduct = 0

  line.split(": ")[1].to_s.split("; ").each do |set|

    set_of_combos = set.split(", ")
    set_of_combos.each do |combo|
      parse_combo = combo.split()

      count = parse_combo[0].to_i
      color = parse_combo[1]

      colorsMaxes = setColorMaxCount(count,color, colorsMaxes)

    end
  end

 colorsProduct = colorsMaxes[:red] * colorsMaxes[:green] * colorsMaxes[:blue]
 colorsProductSum += colorsProduct
end



puts colorsProductSum
