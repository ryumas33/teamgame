# board.rb : borad
#
#
class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end
end

class Board
  attr_reader :p1chip, :p2chip

  def initialize
    @cards = Array.new
    suit = ["H","S","D","C"]
    for s in suit do
      for i in 1..13 do
        @cards << Card.new(s,i)
      end
    end
    @cards.shuffle!

    @p1chip = 100
    @p2chip = 100
  end

  def hit
    if @cards.empty? == false then
      @cards.shift
    else
      puts "All removed."
    end
  end

  #for debug
  def checkcards
    while @cards.empty? == false do
      c = hit
      print c.suit, c.number, "\n"
    end
  end

end

##for debug
#b = Board.new
#b.checkcards
