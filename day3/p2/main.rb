require 'set'

grid = File.readlines("./main.txt").map(&:chomp)

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

hash = {}

grid.each_with_index do |row,r_ind|
  row.chars.each_with_index do |char, c_ind|
    if char != '*'
      next
    end
    s_row = r_ind
    s_col = c_ind
    for cr in [r_ind - 1, r_ind, r_ind + 1]
      for cc in [c_ind - 1, c_ind, c_ind + 1]
        if cr < 0 || cr > grid.length || cc < 0 || cc > grid[cr].length || !(grid[cr][cc].is_integer?)
          next
        end
        while cc > 0 && grid[cr][cc-1].is_integer?
          cc-=1
        end
        if hash.key?([s_row,s_col])
          hash[[s_row,s_col]].add([cr,cc])
        else
          hash[[s_row,s_col]] = Set[[cr,cc]]
        end
      end
    end
  end
end

sum_of_gear_rations = []

hash.each do |k,v|
  cord = k
  set = v
  if set.size != 2
    next
  end

  gear_ratio = []

  set.each do |c|
    x,y = c
    s = ""
    while y < grid[x].length && grid[x][y].is_integer?
      s += grid[x][y]
      y+=1
    end
    num = s.to_i
    gear_ratio.append(num)
  end

  gear_ratio = gear_ratio.reduce(:*)
  sum_of_gear_rations.append(gear_ratio)

end

p sum_of_gear_rations.sum

