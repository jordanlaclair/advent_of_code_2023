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


cord = "AAA"
  counter = 0
  while cord != "ZZZ"


    step = steps[counter % steps.size]

    if step == 'L'
      cord = cordTable[cord][0]
    else
      cord = cordTable[cord][1]
    end

    counter+=1

    if cord == "ZZZ"
      break
    end
  end




puts counter
