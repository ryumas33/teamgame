# coding: utf-8
# player.rb
#
#
class Player
  def initialize
    @myID = 0
    @opponentID = -1
    @myHand = []
    @opponentHand = []
    for i in 0..9 do
      @myHand[i] = -1
      @opponentHand[i] = -1
    end
    @myTotal = -1
    @opponentTotal = -1
    @boardTotal = -1
  end

  def showStatus
    puts "[ player "+@myID+" ]"
    puts "chip : "+@myTotal
    puts "[ player "+@opponentID+" ]"
    puts "chip : "+@opponentTotal
    puts "[ board chip : "+@boardTotal+" ]"
  end
  
  def actionCard
    puts "action? (1:Hit 0:Stand)"
    while 1 do
      myAct = STDIN.gets.to_i
      if myAct==1 || myAct==0 then
        return myAct
      else
        puts "please retype (1or0)"
      end
    end
  end

  def actionBet
    myChip = gunyagunya.chip
    boardRaise = gunyagunya.raise
    
    if @boardTotal==0 then
      puts "action? (check[1] or bet[3])"
      while 1 do
        myBet.action = STDIN.gets.to_i
        if myBet.action==1 then
          puts "player " + @myID + " : check"
          return myBet.action
        elsif myBet.action==3 then
          if myChip < 20 then
            myBet.chip = myChip
            puts "player " + @myID + " : bet All in " + myBet.chip
            return myBet.action
          else
            puts "player " + @myID + " : bet 20"
            return myBet.action
          end
        else
          puts "please retype (1or3)"
        end
      end
      
    else
      if boardRaise==0 then
        puts "action? (fold[0] , call[2] or raise[3])"
      else
        puts "action? (fold[0] or call[2])"
      end
      
      while 1 do
        myBet.action = STDIN.gets.to_i
        if myBet.action==0 then
          puts "player " + myID + " : fold"
        elsif myBet.action==2 then
          if myChip < @boardTotal then
            myBet.chip = myChip
            puts "palyer " + @myID + " : call All in " + myBet.chip
          else
            puts "player " + @myID + " : call"
          end
        elsif myBet.action==3 && boardRaise==0 then
          if myChip < @boardTotal * 2 then
            myBet.chip = myChip
            puts "player " + @myID + " : raise All in " + myBet.chip
          else
            puts "player " + @myID + " : raise make " + myBet.chip
          end
          return myBet.action
        else
          if boardRaise==0 then
            puts "please retype (0,2or3)"
          else
            puts "please retype (0or2)"
          end
        end
      end
    end
  end
end
