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
    put "action? (1:Hit 0:Stand)"
    while 1 then # 1:ヒット(追加) 0:スタンド(勝負)
      myAct = STDIN.gets
      if myAct==1　then
        return 1
      elsif myAct==0 then
        return 0
      else
        put "please retype (1or0)"
      end
    end
  end
end

