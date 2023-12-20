
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
  return true if m.between?(0,$row_len) && n.between?(0,$col_len)
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

def rollUpPiece(m,n,arr)

  initial_m = m.clone

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

  #print_arr($row_len,$col_len,arr)
  arr
end


#print_arr($row_len,$col_len,board)

  for i in (0...$row_len)
    for j in (0...$col_len)
      if i>0
        if isARock(i,j,board)
          board = rollUpPiece(i,j,board)
        end
      end
    end
  end

sum = 0

for i in (0...$row_len)
  counter = 0
  value = $row_len - i
  for j in (0...$col_len)
    if board[i][j] == "O"
      counter += 1
    end
  end
  sum += counter * value
end


print sum