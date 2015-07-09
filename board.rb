# board.rb : borad
#
#
class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
    if number.to_i >= 10 then
      @bjnumber = 10
    else
      @bjnumber = number
    end
  end
  def bjnumber
    @bjnumber
  end
end

class Board
  @@p1chip = 100
  @@p2chip = 100

  def initialize
    @cards = Array.new
    suit = ["H","S","D","C"]
    for s in suit do
      for i in 1..13 do
        @cards << Card.new(s,i)
      end
    end
    @cards.shuffle!
  end

  def p1chip
    @@p1chip
  end

  def p2chip
    @@p2chip
  end

  def p1bet(chip)
    @@p1chip -= chip
  end

  def p2bet(chip)
    @@p2chip -= chip
  end

  def p1get(chip)
    @@p1chip += chip
  end

  def p2get(chip)
    @@p2chip += chip
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
b = Board.new
#b.checkcards
#puts b.p1chip
#puts b.p2chip
