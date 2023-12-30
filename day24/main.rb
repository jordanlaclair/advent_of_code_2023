class Hailstone
  @sx
  @sy
  @sz
  @vx
  @vy
  @vz

  @_a
  @_b
  @_c

  attr_accessor :_a,:_b,:_c,:sx,:sy,:sz,:vx,:vy,:vz

  def initialize(sx,sy,sz,vx,vy,vz)
    @sx = sx
    @sy = sy
    @sz = sz
    @vx = vx
    @vy = vy
    @vz = vz
    @_a = vy
    @_b = -vx
    @_c = vy * sx -vx * sy
  end

end



list = File.readlines("./main.txt").map(&:chomp)
len = list.length
total = 0

for i in (0...len)
  hailstone_a_string = list[i]
  sx,sy,sz = hailstone_a_string[0...hailstone_a_string.index("@")-1].split(", ").map(&:to_f)
  vx,vy,vz = hailstone_a_string[hailstone_a_string.index("@")+1..-1].strip.split(", ").map(&:to_f)
  h1 = Hailstone.new(sx,sy,sz,vx,vy,vz)
  for j in (i+1...len)
    hailstone_b_string = list[j]
    sx,sy,sz = hailstone_b_string[0...hailstone_b_string.index("@")-1].split(", ").map(&:to_f)
    vx,vy,vz = hailstone_b_string[hailstone_b_string.index("@")+1..-1].strip.split(", ").map(&:to_f)
    h2 = Hailstone.new(sx,sy,sz,vx,vy,vz)
    a1,b1,c1 = h1._a,h1._b,h1._c
    a2,b2,c2 = h2._a,h2._b,h2._c

    if (a1 * b2) == (a2 * b1)
      next
    end

    x = (c1 * b2 - c2 * b1) / (a1 * b2 -a2 * b1)
    y = (c2 * a1 - c1 * a2) / (a1 * b2 -a2 * b1)
    if x.between?(200000000000000,400000000000000) && y.between?(200000000000000,400000000000000)
      if [h1,h2].all? {|hs| (x-hs.sx) * hs.vx >= 0 && (y-hs.sy) * hs.vy >= 0 }
        total += 1
      end
    end

  end
end

puts total