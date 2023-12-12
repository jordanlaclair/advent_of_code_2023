races = {}
arr_of_times = []
arr_of_distances = []
records = []

IO.readlines("./main.txt").map(&:chomp).map do |line|
  if(line.include?("Time"))
     arr_of_times = line.split(":")[1].delete(' ').split
  end
  if(line.include?("Distance"))
    arr_of_distances = line.split(":")[1].delete(' ').split
 end
end

arr_of_times.each_with_index do |i,index|
  races[index] = {time: i, distance: arr_of_distances[index]}
end


races.each do |key, value|

total_time = value[:time].to_i
distance_to_beat = value[:distance].to_i


elapsed_time = 0
remaining_seconds = 0
record_counter = 0

while elapsed_time != total_time

    remaining_seconds = total_time - elapsed_time

    total_distance_traveled = remaining_seconds * elapsed_time

    if total_distance_traveled > distance_to_beat
      record_counter += 1
    end

    elapsed_time += 1
end

  if record_counter > 0
    records.append(record_counter)
  end
end

temp = 0
records.each do |i|
  if temp > 0
    temp = temp * i
  else
    temp = i
  end
end

p temp
