cache = {}

def process(str, numbers, cache)

  return 1 if (str.nil? || str.empty?) && numbers.empty?
  return 0 if (str.nil? || str.empty?) && !numbers.empty?

  return 0 if numbers.empty? && str.include?("#")
  return 1 if numbers.empty? && !str.include?("#")


  key = [str, numbers]

  if cache.key?(key)
      return cache[key]
  end

  result = 0

    #its period, remove it
    if ".?".include?(str[0])
      result += process(str[1..-1], numbers, cache)
    end

    #its hashtag
    if "#?".include?(str[0])
      if numbers[0] <= str.size && !str[0,numbers[0]].include?(".") && (str[numbers[0]] != "#" || str.size == numbers[0])
        result += process(str[numbers[0]+1..-1], numbers[1..-1], cache)
      end
    end

    cache[key] = result

    return result
end

total = 0

IO.readlines("./main.txt").map(&:chomp).each do |line|
  config,numbers = line.split

  numbers_arr = numbers.split(",").map(&:to_i)

  config =  ((config + "x") * 5).split("x").join("?")

  numbers_arr *= 5


  total += process(config, numbers_arr, cache)

end

puts total
