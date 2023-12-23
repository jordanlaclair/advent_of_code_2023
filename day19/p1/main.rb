input = ""
functions_string = ""
File.readlines("./main.txt").each do |line|
  input += line
end

functions_string = input.split("-")[0]
calls = input.split("-")[1].strip

def parseFunctionString(str)
  name = str.split("{")[0]
  conditionals = str.split("{")[1][0...-1].split(",")
  [name,conditionals]
end

function_list = {}
functions_string.split("\n").each do |str|
  name,conditionals = parseFunctionString(str)
  function_list[name] = conditionals
end


function_list.each do|k,v|
  puts "#{k} => #{v}"
end
puts ""

def processFunction(conditions, vars,function_list)
   processConditions(conditions,vars,function_list)
end

def processConditions(conditions, vars,function_list)
  conditions.each do |condition|
    res = ""
    if condition.include?("<")
      res = processLessThanCondition(condition,vars,function_list)
      return "A" if res == "A"
      return "R" if res == "R"
    elsif condition.include?(">")
      res = processGreaterThanCondition(condition,vars,function_list)
      return "A" if res == "A"
      return "R" if res == "R"
    elsif condition == "A"
      return "A"
    elsif condition == "R"
      return "R"

    else
      return processFunction(function_list[condition], vars, function_list)
    end
  end
end

def processLessThanCondition(str,vars,function_list)
  str_var = str.split("<")[0]
  str_var_value = str.split("<")[1].split(":")[0].to_i
  var_value = vars[str_var]
  function = str.split(":")[1]
  # puts "function #{function}"
  # puts str_var
  # puts "#{var_value} < #{str_var_value}"
    if var_value < str_var_value
        return function if function == "A" or function == "R"
        processFunction(function_list[function], vars, function_list)
    end
end

def processGreaterThanCondition(str,vars,function_list)
  str_var = str.split(">")[0]

  str_var_value = str.split(">")[1].split(":")[0].to_i
  var_value = vars[str_var]
  function = str.split(":")[1]
  # puts "function #{function}"
  # puts str_var
  # puts "#{var_value} > #{str_var_value}"

  if var_value > str_var_value
    return function if function == "A" or function == "R"
    processFunction(function_list[function], vars, function_list)
  end
end

total = 0
calls.split("\n").each do |str|
  hash = {}
  str.delete("{").delete("}").split(",").each do |i|
    var = i.split("=")[0]
    value = i.split("=")[1].to_i
    hash[var] = value
  end

  puts hash
  res = processFunction(function_list["in"], hash,function_list)
  puts res
  if res == "A"
    parts_total = hash.values.sum
    total+= parts_total
  end
  puts ""
  puts ""
end

puts total