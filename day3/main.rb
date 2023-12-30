require 'set'

grid = File.readlines("./main.txt").map(&:chomp)

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

set = Set.new

grid.each_with_index do |row,r_ind|
  row.chars.each_with_index do |char, c_ind|
    if char.is_integer? || char == '.'
      next
    end
    for cr in [r_ind - 1, r_ind, r_ind + 1]
      for cc in [c_ind - 1, c_ind, c_ind + 1]
        if cr < 0 || cr > grid.length || cc < 0 || cc > grid[cr].length || !(grid[cr][cc].is_integer?)
          next
        end
        while cc > 0 && grid[cr][cc-1].is_integer?
          cc-=1
        end
        set.add([cr,cc])
      end
    end
  end
end


total = 0

set.each do |cord|
  x,y = cord
  s = ""
  while y < grid[x].length && grid[x][y].is_integer?
    s += grid[x][y]
    y+=1
  end
  num = s.to_i

  total += num
end
p total