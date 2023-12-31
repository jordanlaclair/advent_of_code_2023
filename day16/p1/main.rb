require 'set'

grid = File.readlines("./main.txt").map(&:chomp)

queue = []
seen = Set.new
#r,c,dr,dc
a = [0,-1,0,1]

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

p set.length