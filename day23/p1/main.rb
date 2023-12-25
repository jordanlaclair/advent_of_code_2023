require 'set'

#readlines reads file and creates array separated by "\n"
grid = File.readlines("./main.txt").map(&:chomp)
grid_start = [0,grid[0].index(".")]
$grid_end = [grid.length-1,grid[-1].index(".")]
points = [grid_start, $grid_end]

grid.each_with_index do |row, rowIndex|
  row.chars.each_with_index do |col, colIndex|

    if grid[rowIndex][colIndex] == "#"
      next
    end

    neighbors = 0
    [[rowIndex - 1, colIndex], [rowIndex, colIndex -1], [rowIndex + 1, colIndex], [rowIndex, colIndex + 1]]
      .each_with_index do |k, ind|
      neigh_row = k[0]
      neigh_col = k[1]
      if 0 <= neigh_row && neigh_row <= grid.size - 1 && 0 <= neigh_col && neigh_col <= grid[0].size - 1 && grid[neigh_row][neigh_col] != "#"
        neighbors+=1
      end
    end
    if neighbors >= 3
      points.append([rowIndex, colIndex])
    end

  end
end

p points
$points_graph_adj_list = {}
points.each do |i|
  $points_graph_adj_list[i] = []
end


#{[3, 11]=>[], [5, 3]=>[], [11, 21]=>[], [13, 5]=>[], [13, 13]=>[], [19, 13]=>[], [19, 19]=>[]}


dict = {
  "^": [[-1,0]],
  "v": [[1,0]],
  "<": [[0,-1]],
  ">": [[0,1]],
  ".": [[-1,0],[1,0],[0,-1],[0,1]]
}



#[[3, 11], [5, 3], [11, 21], [13, 5], [13, 13], [19, 13], [19, 19]]

points.each do |k|
  s_row = k[0]
  s_col = k[1]

  stack = []
  seen = []

  n=0
  stack.append([n,s_row, s_col])
  seen.append([s_row, s_col])

  while stack.size != 0

    n, n_row, n_col = stack.pop
    #puts n, n_row, n_col

    found = false

    points.each do |point|
      x,y = point
      if x == n_row && n_col == y
        found = true
      end
    end

    if n != 0 && found

      $points_graph_adj_list[[s_row,s_col]].append( [[n_row, n_col],n]  )
      next
    end


    dict[grid[n_row][n_col].to_sym].each do |dr,dc|
      r = n_row + dr
      c = n_col + dc
      if 0 <= r && r <= grid.size - 1 && 0 <= c && c <= grid[0].size - 1 && grid[r][c] != "#" && seen.index([r, c]).nil?
        stack.append([n+1,r,c])
        seen.append([r,c])
      end
    end

  end

end
$points_graph_adj_list.each do |k,v|
  p k,v
  puts ""
end

$seen = Set[]

p $points_graph_adj_list[[0,1]]
def dfs(x,y)

  x1,y1 = $grid_end
  if x1 == x and y1 == y
    return 0
  end

  m = -1
  $seen.add([x,y])
  $points_graph_adj_list[[x,y]].each do |i|
    if !$seen.include?([i[0][0],i[0][1]])
      m = [m, dfs(i[0][0], i[0][1]) + i[1]].max
    end
  end
  $seen.delete([x,y])
  return m

end

x,y = grid_start

puts dfs(x,y)