
differences_stack = []

IO.readlines("./main.txt").map(&:chomp).each_with_index do |line,index|

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
end


x = 0
sum = 0
while differences_stack.size != 0

  x = differences_stack.last.last


  if x == 0
    differences_stack.pop
    next
  end


  x = differences_stack.last.last
  differences_stack.pop

  sum += x


end

puts sum
