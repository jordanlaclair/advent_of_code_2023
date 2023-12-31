require 'set'

grid = File.readlines("./main.txt").map(&:chomp)

def energize(r,c,dr,dc,grid)
  queue = []
  seen = Set.new
  #r,c,dr,dc
  a = [r,c,dr,dc]

  queue.append(a)

  while queue.length != 0
    r,c,dr,dc = queue.shift

    r+=dr
    c+=dc

    if r < 0 or r >= grid.length or  c< 0 or c >= grid[0].length
      next
    end

    ch = grid[r][c]

    if ch == '.' or (ch == '-' and dc != 0) or (ch == '|' and dr != 0)
      if !seen.include?([r,c,dr,dc])
        seen.add([r,c,dr,dc])
        queue.append([r,c,dr,dc])
      end
    elsif ch == "/"
      dr,dc = -dc,-dr
      if !seen.include?([r,c,dr,dc])
        seen.add([r,c,dr,dc])
        queue.append([r,c,dr,dc])
      end

    elsif ch == "\\"
      dr,dc = dc,dr
      if !seen.include?([r,c,dr,dc])
        seen.add([r,c,dr,dc])
        queue.append([r,c,dr,dc])
      end
    elsif ch == '|'
      [[1,0],[-1,0]].each do |cord|
        dr,dc = cord
        if !seen.include?([r,c,dr,dc])
          seen.add([r,c,dr,dc])
          queue.append([r,c,dr,dc])
        end
      end
    else
      [[0,1],[0,-1]].each do |cord|
        dr,dc = cord
        if !seen.include?([r,c,dr,dc])
          seen.add([r,c,dr,dc])
          queue.append([r,c,dr,dc])
        end
      end
    end
  end

  set = Set.new
  seen.each do |i|
    r,c,dr,dc = i
    set.add([r,c])
  end
  set.length
end


max_val = 0


#left and right
grid.each_with_index do |i,r|
  max_val = [max_val,energize(r,-1,0,1,grid )].max
  max_val = [max_val,energize(r,grid[0].length,0, -1,grid )].max
end
#top bottom
grid.each_with_index do |i,c|
  max_val = [max_val,energize(-1,c,1,0,grid )].max
  max_val = [max_val,energize(grid.length,c,-1, 0,grid )].max
end

puts max_val