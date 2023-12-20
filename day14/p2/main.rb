
board=[]
File.readlines("main.txt").map(&:chomp).each do|line|
  board.append(line.chars)
end

$row_len = board.size
$col_len = board[0].size


def print_arr(rows,columns,arr)
  for i in (0...rows)
    for j in (0...columns)
      print arr[i][j]
    end
    puts ""
  end
  puts ""
end
def validBounds(m,n)
  return true if (m.between?(0,$row_len-1) && n.between?(0,$col_len-1))
  false
end

def isEmptySpace(m,n,arr)
  return true if arr[m][n] == '.'
  false
end

def canMovePieceOnceUp(m,n,arr)
  return true if validBounds(m,n) && isEmptySpace(m,n,arr)
  false
end

def isARockOrZero(m,n,arr)
  return true if arr[m][n] == 'O' or arr[m][n] == '#'
  false
end


def isARock(m,n,arr)
  return true if arr[m][n] == 'O'
  false
end

def rollNorth(rows,cols,arr)
  rows = rows - 1
  cols = cols - 1
  for i in (1..rows)
    for j in (0..cols)
      m = i
      initial_m = m.clone
      n = j
      if isARock(m,n,arr)
          if m == 1
            if isEmptySpace(m-1,n,arr) && validBounds(m-1,n)
              arr[m-1][n] = "O"
              arr[m][n] = "."
            end
            arr
          end
          m-=1
          while isEmptySpace(m,n,arr) && validBounds(m,n)
            m-=1
          end
          if isEmptySpace(m+1,n,arr) && validBounds(m+1,n)
            arr[m+1][n] = "O"
            arr[initial_m][n] = "."
          end
      end
    end
  end
  arr
end


def rollSouth(rows,cols,arr)
  rows = rows-2
  for i in rows.downto(0)
    for j in (0...cols)
      m = i
      initial_m = m.clone
      n = j
      if isARock(m,n,arr)
        if m == rows
          if isEmptySpace(m+1,n,arr) && validBounds(m+1,n)
            arr[m+1][n] = "O"
            arr[m][n] = "."
          end
          arr
        end
        m+=1
        while validBounds(m,n) && isEmptySpace(m,n,arr)
          m+=1
        end
        if validBounds(m-1,n) && isEmptySpace(m-1,n,arr)
          arr[m-1][n] = "O"
          arr[initial_m][n] = "."
        end
      end
    end
  end
  arr
end



def rollEast(rows,cols,arr)
  rows = rows-1
  cols = cols-2
  for i in (0..rows)
    for j in cols.downto(0)
      m = i
      n = j
      initial_n = n.clone
      if isARock(m,n,arr)
        if n == cols
          if isEmptySpace(m,n+1,arr) && validBounds(m,n+1)
            arr[m][n+1] = "O"
            arr[m][n] = "."
          end
          arr
        end
        n+=1
        while validBounds(m,n) && isEmptySpace(m,n,arr)
          n+=1
        end
        if validBounds(m,n-1) && isEmptySpace(m,n-1,arr)
          arr[m][n-1] = "O"
          arr[m][initial_n] = "."
        end
      end
    end
  end
  arr
end

def rollWest(rows,cols,arr)
  rows = rows-1
  cols = cols-1
  for i in (0..rows)
    for j in (1..cols)
      m = i
      n = j
      initial_n = n.clone
      if isARock(m,n,arr)
        if n == 1
          if isEmptySpace(m,n-1,arr) && validBounds(m,n-1)
            arr[m][n-1] = "O"
            arr[m][n] = "."
          end
          arr
        end
        n-=1
        while validBounds(m,n) && isEmptySpace(m,n,arr)
          n-=1
        end
        if validBounds(m,n+1) && isEmptySpace(m,n+1,arr)
          arr[m][n+1] = "O"
          arr[m][initial_n] = "."
        end
      end
    end
  end
  arr
end

def getSum(arr)
  sum = 0

  for i in (0...$row_len)
    counter = 0
    value = $row_len - i
    for j in (0...$col_len)
      if arr[i][j] == "O"
        counter += 1
      end
    end
    sum += counter * value
  end
  sum
end


cycles = 10**9
#print_arr($row_len,$col_len,board)
cycle_list = {}
seen = {}


def rotateArray(board)
  board = rollNorth($row_len,$col_len,board)
  board = rollWest($row_len,$col_len,board)
  board = rollSouth($row_len,$col_len,board)
  board = rollEast($row_len,$col_len,board)
  board
end


cycles.times do |i|
  board = rotateArray(board).clone

  state = board.map(&:dup)

  if seen.key?(state)
    period = i - seen[state]

    ans_grid = cycle_list[(10**9 - 1 - seen[state]) % period + seen[state]]
    p getSum(ans_grid)
    break
  else
    cycle_list[i] = state
    seen[state] = i
  end

end
