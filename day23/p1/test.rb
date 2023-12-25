require 'set'

set1 = Set[]

set1.add([2,4])
set1.delete([2,4])
x = set1.include?([2,4])
p x