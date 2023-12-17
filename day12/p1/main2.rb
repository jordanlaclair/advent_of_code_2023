def count(cfg, nums)

  return 1 if (cfg.nil? || cfg.empty?) && nums.empty?
  return 0 if (cfg.nil? || cfg.empty?) && !nums.empty?

  return 0 if nums.empty? && cfg.include?("#")
  return 1 if nums.empty? && !cfg.include?("#")


  result = 0


  if ".?".include?(cfg[0])
    result += count(cfg[1..-1], nums)
  end

  if "#?".include?(cfg[0])
    if nums[0] <= cfg.length && !cfg[0, nums[0]].include?(".") && (nums[0] == cfg.length || cfg[nums[0]] != "#")
      result += count(cfg[nums[0] + 1..-1], nums[1..-1])
    end
  end

  result
end


total = 0

IO.readlines("./main.txt").map(&:chomp).each do |line|
  cfg, nums_str = line.split
  nums = nums_str.split(",").map(&:to_i).to_a

  total += count(cfg, nums)


end

puts total
