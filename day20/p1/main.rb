$modules_hash = {}

class ModuleClass
  @pulse
  @destinations
  @sent_pulses
end

class BroadcastModule < ModuleClass
  @pulse
  @destinations
  @sent_pulses
  attr_accessor :destinations, :pulse, :sent_pulses

  def initialize
    @pulse = 0
    @destinations = []
    @sent_pulses = []
  end
  def setPulseLow
    @pulse = 0
  end

  def sendPulse
    @destinations.each do |i|
      p $modules_hash[i]
      @sent_pulses.append(@pulse)
      $modules_hash[i].receivePulse(@pulse)
    end
    nil
  end


  def getDestinations
    @destinations
  end

end

class ButtonModule < ModuleClass
  @pulse
  @broadcaster
  @sent_pulses
  attr_accessor :pulse,:broadcaster, :sent_pulses

  def initialize
    @pulse = 0
    @broadcaster = BroadcastModule
    @sent_pulses = []
  end

  def addBroadcaster(broadcaster)
    @broadcaster = (broadcaster)
  end
  def setBroadcasterPulse
    @broadcaster.setPulseLow
    @sent_pulses.append(@pulse)
  end


end
class FlipFlopModule < ModuleClass
  @pulse
  @state
  @destinations
  @sent_pulses
  attr_accessor :pulse,:broadcaster,:state, :sent_pulses

  def initialize(destinations)
    @destinations = []
    @pulse = 0
    @state = 0
    @destinations = destinations
    @sent_pulses = []
  end

  def receivePulse(pulse)
    if pulse == 0
      switchState
    end
    sendPulse
  end

  def configPulse
    if @state == 1
      @state = 0
      @pulse = 1
    else
      @state = 0
      @pulse = 0
    end
  end

  def sendPulse
    configPulse
    @destinations.each do |i|
      @sent_pulses.append(@pulse)
      $modules_hash[i].receivePulse(@pulse)
    end
  end

  def switchState
    @state = 1 - @state
  end



  def getDestinations
    @destinations
  end

end

class ConjunctionModule < ModuleClass
  @pulse
  @destinations
  @input_types
  @sent_pulses
  attr_accessor :pulse,:destinations,:input_types, :sent_pulses
  def initialize(destinations)
    @pulse = 0
    @destinations = []
    @input_types = []
    @sent_pulses = []
    @destinations = destinations
  end

  def receivePulse(pulse)
    @input_types.append(pulse)
    sendPulse
  end

  def configPulse
    flag = true
    @input_types.each do |i|
      if i == 0
        flag = false
        break
      end
    end
    if flag
      @pulse = 1
    else
      @pulse = 0
    end
  end
  def sendPulse
    configPulse
    @destinations.map! do |i|
      @sent_pulses.append(@pulse)
      $modules_hash[i].receivePulse(@pulse)
    end
  end



  def getDestinations
    @destinations
  end

end


list = File.readlines("./main.txt").map(&:chomp)[0]

modules = File.readlines("./main.txt").map(&:chomp)[1..-1]


modules.each do |m|
  type = m[0]
  name = m[1...m.strip.index("-")-1]
  destinations = m[m.index("->")+3..-1].split(",")

  case type
  when "%"
    obj = FlipFlopModule.new(destinations)
  when "&"
    obj = ConjunctionModule.new(destinations)
  else
    UncaughtThrowError
  end

  if $modules_hash.key?(name)
  else
    $modules_hash[name] = obj
  end

end


def print_hash(hash)
  hash.each do |k,v|
    puts k
    p v
    puts ""
    puts ""
  end
end



print_hash($modules_hash)
queue = []
def processList(list,queue)
  button = ButtonModule.new
  broadcaster = BroadcastModule.new
  button.addBroadcaster(broadcaster)


list = list.split("-> ")[1].split(", ").each
  list.each do |i|
    queue.append(i)
  end


  queue.each do |i|
    puts i
    queue.shift
    $modules_hash[i].getDestinations.each do |j|
      #queue.append(j)
    end

  end

end
#a b c b

processList(list,queue)


