# board.rb : borad
#
#
class Card
  def initialize(suit, number)
    @suit = suit
    @number = number
  end
end

class Board
  def initialize
    @cards = Array.new
    suit = ["H","S","D","C"]
    for s in suit do
      for i in 1..13 do
        @cards.add(Card.new(s,i))
      end
    end
    @cards.shuffle

    @p1chip = 100
    @p2chip = 100
  end

  def hit
    @cards.shift
  end

end
