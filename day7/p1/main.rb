class CardType
  attr_accessor :name,:value
  def initialize(name = "", value = 0)
    @name = name
    @value = value
  end
end

class TypeStrategy
  @card_type
  @cards

  def initialize(cards)
    @cards = cards
    @card_type
  end

  def self.cards
    @cards
end

end

class FiveOfAKindStrategy < TypeStrategy

  def initialize(cards)
    super(cards)
  end

  def setType
    card = @cards[0]
    flag = true

    @cards.each do |i|
      if i != card
       flag = false
    end
    end

    if flag == true
      @card_type = CardType.new("Five of a Kind", 1)
    end
  end

  def get_card_type
    @card_type
  end
end


def OfAKind(cards, of_a_kind_count, remainingCardsStrategy)
  first_card = @cards[0]
  different_card = ""

  first_card_count = 0
  different_card_count = 0

  cards.each do |i|
    occurences = cards.count(i)
    if occurences == of_a_kind_count
      return true if reminaingCardsHandler(cards.reject{|j| j == i},remainingCardsStrategy)
    end
  end

return nil
end

def reminaingCardsHandler(cards, handler)
  if handler == "RemainingCardsSame"
    return true if reminaingCardsSame(cards)
  end
  if handler == "RemainingCardsDifferentFromHand"
    return true if reminaingCardsDifferent(cards)
  end
end


def reminaingCardsSame(cards)
  cards.uniq.size == 1
end

def reminaingCardsDifferent(cards)
  cards.uniq.size != 1
end



class FourOfAKindStrategy < TypeStrategy
  @of_a_kind_count

  def initialize(cards)
    @of_a_kind_count = 4
    super(cards)
  end


  def setType
    if(OfAKind(@cards, @of_a_kind_count, "RemainingCardsSame"))
      @card_type = CardType.new("Four of a Kind", 2)
    end
  end

  def get_card_type
    @card_type
  end
end

class FullHouse < TypeStrategy
  @of_a_kind_count

  def initialize(cards)
    @of_a_kind_count = 3
    super(cards)
  end


  def setType
    if(OfAKind(@cards, @of_a_kind_count, "RemainingCardsSame"))
      @card_type = CardType.new("FullHouse", 3)
    end
  end

  def get_card_type
    @card_type
  end
end


class ThreeOfAKind < TypeStrategy
  @of_a_kind_count

  def initialize(cards)
    @of_a_kind_count = 3
    super(cards)
  end


  def setType
    if(OfAKind(@cards, @of_a_kind_count, "RemainingCardsDifferentFromHand"))
      @card_type = CardType.new("Three of a Kind", 4)
    end
  end

  def get_card_type
    @card_type
  end
  def cards
    @cards
  end
end









class Hand
attr_accessor :bid, :cards, :rank, :score, :type

def initialize
  @bid = 0
  @cards = []
  @rank = 0
  @score  = 0
  @type = 0
end

def type
strategy1 = FiveOfAKindStrategy.new(self.cards)
strategy1.setType

strategy2 = FourOfAKindStrategy.new(self.cards)
strategy2.setType

strategy3 = FullHouse.new(self.cards)
strategy3.setType

strategy4 = ThreeOfAKind.new(self.cards)
strategy4.setType




if(strategy1.get_card_type)
  #p strategy1.get_card_type
end

if(strategy2.get_card_type)
  #p strategy2.get_card_type
end

if(strategy3.get_card_type)
  #p strategy3.get_card_type
end

if(strategy4.get_card_type)
  p strategy4.get_card_type
end

end

end

IO.readlines("./main.txt").map(&:chomp).each do |line|
  hand = Hand.new
  hand.cards = line.split()[0].chars
  hand.bid = line.split()[1].to_i
  hand.type()
end
