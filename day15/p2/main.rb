input = ""
File.readlines("./main.txt").map(&:chomp).each do |line|
  input += line
end


def getBoxNumber(str)
  curr = 0
  str.chars.each do|char|
    curr += char.ord
    curr *= 17
    curr %= 256
  end
  curr
end

def getLabel(str)
  if str.include?("-")
    str = str.split("-")[0]
  elsif str.include?("=")
    str = str.split("=")[0]
  end
  str
end


def getFocalLength(str)
  if str.include?("=")
    str = str.split("=")[1]
  end
  str
end




def operationEqual(str,hash)
  label = getLabel(str)
  boxNumber = getBoxNumber(label)
  focalLength = getFocalLength(str)

  if hash.key?(boxNumber)
    duplicate = false
    boxArr = hash[boxNumber]

    boxArr.map do |obj|
      if obj[:label] == label
        obj[:focalLength] = focalLength
        duplicate = true
      end
    end
    if !duplicate
      hash[boxNumber].append({label: label,focalLength: focalLength })
    end
  else
    hash[boxNumber] = []
    hash[boxNumber].append({label: label,focalLength: focalLength })
  end


end

def operationDash(str,hash)
  label = getLabel(str)
  boxNumber = getBoxNumber(label)
  if hash.key?(boxNumber)
    hash[boxNumber].reject! { |h| h[:label] == label }
  end
end


hash = {}
input.split(",").each do |str|

  if str.include?("-")
    operationDash(str,hash)
  elsif str.include?("=")
    operationEqual(str,hash)
  end

end


sum = 0
hash.each do |k,v|
  box = k
  arr = v

  arr.each_with_index do |hash,index|
    sum += (box + 1) * (index + 1) * hash[:focalLength].to_i
  end

end


p sum


