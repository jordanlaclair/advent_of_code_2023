#Pick's theorem provides a formula for the area of a simple polygon
# with integer vertex coordinates,
# in terms of the number of integer points within it and on its boundary.
# A = i + b/2 -1
# b = boundary points (outer)
# i = interior points (outer)



#The shoelace formula, also known as Gauss's area formula and the surveyor's formula,[1]
# is a mathematical algorithm to determine the area of a simple polygon whose
# vertices are described by their Cartesian coordinates in the plane.[2]
# It is called the shoelace formula because of the constant cross-multiplying for
# the coordinates making up the polygon, like threading shoelaces
# A = sum of xi*(y+1-y-1)/2

points = [[0,0]]
boundary_points = 0
dirs = {
  "3": [-1,0],
  "1": [1,0],
  "0": [0,1],
  "2": [0,-1]
}

File.readlines("./main.txt").map(&:chomp).each do |line|
  _,_,hex= line.split
  d = hex[-2]
  n_hex = hex[2..-3]
  n = n_hex.to_i(16)

  dr,dc = dirs[d.to_sym]


  boundary_points+=n
  r,c = points[-1]
  points.append([dr * n + r, dc * n + c])
end



#shoelace formula to get area
# A = sum of xi*(y+1-y-1)/2
sum = 0
for i in (0...points.length)
  sum += points[i][0] * (points[i-1][1] - points[(i+1) % points.length][1])
end

sum = sum.abs / 2
area = sum

#substitte the area into picks theorem
# # A = i + b/2 -1
# # b = boundary points (outer)
# # i = interior points (outer)

i = area - boundary_points/2 + 1
puts i+boundary_points