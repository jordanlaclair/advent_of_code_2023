file = File.readlines("./main.txt").map(&:chomp)

column_array=[]
row_array=[]
total = 0

file.each_with_index do |i, index|
  column_array = i.chars
  row_array.append(column_array)
end


def in_bounds(x,y)

end

class String
  def is_i?
     !!(self =~ /\A[-+]?[0-9]+\z/)
  end
end


def left_right_index_in_bounds(columns, maxColumns)
  if (0 <= columns) && (columns <= maxColumns)
    return true
  end
  return false
end

def is_symbol(char)
if char != "."
  return true
end
return false
end

def rows_in_bounds(rows, maxRows)
  if (0 <= rows) && (rows <= maxRows)
    return true
  end
  return false
end


def is_symbol(char)
if char != "." && (not char.is_i?)
  return true
end
return false
end


num = ""
maxColumns = row_array.size - 1
maxRows = column_array.size - 1

row_array.each_with_index do |i,index1|

  i.each_with_index do |j,index2|
    if j.is_i?
      num += j
    else
      if num.size > 0
        #left
        if left_right_index_in_bounds(index2-num.size-1, maxColumns)
          if is_symbol(j)
            #puts 'left'
            #p num
            total += num.to_i
          end
        end
        #right
        if left_right_index_in_bounds(index2, maxColumns)
          if is_symbol(j)
            #p 'right'
            #p num
            total += num.to_i
          end
        end

        top = index1-1

        if rows_in_bounds(top, maxRows)
          length = num.size + 1

          length.times do |x|
            if is_symbol(row_array[top][index2-num.size+x-1])
              #p 'top'
              #p num
              total += num.to_i
          end
        end
      end

      bottom = index1+1

      if rows_in_bounds(bottom, maxRows)
        length = num.size + 1
        length.times do |x|
          if is_symbol(row_array[bottom][index2-num.size+x-1])
            p 'bottom'
            p num
            total += num.to_i
          end
        end
      end


      end
      num = ""
    end
  end
  puts ""
end


p total
