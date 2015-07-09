# coding: utf-8
# player.rb
#
#

class Player
  def initialize
    myHand = []
    opponentHand = []
    for i in 0..9 do
      myHand[i] = -1
      opponentHand[i] = -1
    end
    myChip = 0
    myTotal = -1
  end
  
  
  def actionCard
    puts "action? (1:Hit 0:Stand)"
    while 1 do
      myAct = STDIN.gets
      if myAct.to_i==1 then
        return 1
      elsif myAct.to_i==0 then
        return 0
      else
        puts "please retype (1or0)"
      end
    end
  end
  
end
