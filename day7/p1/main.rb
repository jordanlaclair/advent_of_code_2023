


class CardType
  attr_accessor :name,:value
  def initialize
    @name = ""
    @value = 0
  end
end

class TypeStrategy
  @@card_type = CardType.new
  @@cards



  def initialize(cards)
    @@cards = cards
    @@card_type = CardType.new
  end

  def self.card_type
    @@card_type
end

end

class AllSameCardsStrategy < TypeStrategy

  def initialize(cards)
    super(cards)
  end

  def setType
    card = @@cards[0]
    flag = true

    @@cards.each do |i|
      if i != card
       flag = false
    end
    end

    if flag == true
      @@card_type.name = "Five of a Kind"
      @@card_type.value = 1
    end
  end

  def get_card_type
    @@card_type
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
strategy1 = AllSameCardsStrategy.new(self.cards)
strategy1.setType



if(strategy1.get_card_type.name != "")
  p strategy1.get_card_type
end

end

end

IO.readlines("./main.txt").map(&:chomp).each do |line|
  hand = Hand.new
  hand.cards = line.split()[0].chars
  hand.bid = line.split()[1].to_i
  hand.type()
end
