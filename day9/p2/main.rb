sum = 0

IO.readlines("./main.txt").map(&:chomp).each_with_index do |line,index|
  differences_stack = []

 line = line.split.map(&:to_i)
 differences_stack.push(line)
 arr_ptr = line

while arr_ptr.sum != 0
  arr = [].clone
  len = arr_ptr.length

  arr_ptr.each_with_index do |i,index|

    if index+1 >= len
      break
    end

    value = arr_ptr[index+1] - arr_ptr[index]
    arr.push(value)
  end

  arr_ptr = arr

  differences_stack.push(arr)

  #puts arr_ptr
end

x = 0
while differences_stack.size != 0


  if x == 0
    x = differences_stack.last.first
    differences_stack.pop
    next
  else
    x = differences_stack.last.first - x
    differences_stack.pop
  end

end

sum += x


end


puts sum
