routes = ""
cordTable = {}
IO.readlines("./main.txt").map(&:chomp).each_with_index do |line,index|

if index == 0
  routes = line
elsif line.size > 0
    cordTable[line.split(" =")[0]] = line.split("= ")[1].delete!("(").delete!(")").delete(" ").split(",")
end
end

steps = routes



def stepsToTake(cord, steps, cordTable)
  counter = 0
  while cord[-1] != "Z"

    step = steps[counter % steps.size]

    if step == 'L'
      cord = cordTable[cord][0]
    else
      cord = cordTable[cord][1]
    end

    counter+=1

    if cord[-1] == "Z"
      break
    end
  end

  return counter
end



cords = []
cordTable.each do |(key,value)|
  if key[-1] == "A"
    cords.append(key)
  end
end

stepsToTakeArray = []

cords.each do |i|
  stepsToTakeArray.push(stepsToTake(i, steps, cordTable))
end

puts stepsToTakeArray.reduce(1) { |acc, n| acc.lcm(n) }
