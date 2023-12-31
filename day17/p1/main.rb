require 'algorithms'
require 'set'
include Containers

grid =  File.readlines("./main.txt").map(&:chomp).map(&:chars).map{|row| row.map(&:to_i)}
seen = Set.new
#override heap to make the priority the smallest value instead of the largest value
q = PriorityQueue.new {|x, y| (x <=> y) == -1 }

q.push([0,0,0,0,0,0], 0)

while q.size != 0

  hl,r,c,dr,dc,n = q.pop

  if r == grid.length-1 and c == grid[0].length-1
    puts hl
    break
  end

  if r < 0 or r >= grid.length or c < 0 or c >= grid[0].length
    next
  end

  if seen.include?([r,c,dr,dc,n])
    next
  end

  seen.add([r,c,dr,dc,n])

  if n<3 and ([dr,dc] != [0,0])
    nr = r + dr
    nc = c + dc
    if (0 <= nr and nr < grid.length) and (0 <= nc and nc < grid[0].length)
      q.push([hl + grid[nr][nc],nr,nc,dr,dc,n+1], hl + grid[nr][nc])
    end
  end

  [[0,1],[1,0],[0,-1],[-1,0]].each do |cord|
    ndr,ndc = cord
    if ([ndr,ndc] != [dr,dc]) and ([ndr,ndc] != [-dr,-dc])
      nr = ndr + r
      nc = ndc + c
      if (0 <= nr and nr < grid.length) and (0 <= nc and nc < grid[0].length)
        q.push([hl + grid[nr][nc],nr,nc,ndr,ndc,1], hl + grid[nr][nc])
      end
    end
  end


end