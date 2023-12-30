class ModuleClass
  @pulse = 0
  @destinations = []
end

class BroadcastModule < ModuleClass
  @pulse = 0
  @destinations = []
end

class ButtonModule < ModuleClass
  @pulse = 0
  @destinations = []
end
class FlipFlopModule < ModuleClass
  @pulse = 0
  @destinations = []
end

class ConjunctionModule < ModuleClass
  @pulse = 0
  @destinations = []
  @inputs = []
end


list = File.readlines[0]
p list