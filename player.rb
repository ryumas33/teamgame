# coding: utf-8
# player.rb
#
#
class Player
  #プレイヤー番号、手札、持ち金と場の賭け金
  def initialize
    @myID = 0
    @opponentID = -1
    @myHand = []
    @opponentHand = []
    for i in 0..9 do
      @myHand[i] = -1
      @opponentHand[i] = -1
    end
    @myBetCount = -1
    @myCheckCount = -1
    @myCallCount = -1
    @myTotal = -1
    @opponentTotal = -1
  end

  #持ち金と場の賭け金の確認
  def showStatus
    puts "[ player "+@myID+" ]"
    puts "chip : "+@myTotal
    puts "[ player "+@opponentID+" ]"
    puts "chip : "+@opponentTotal
    puts "[ board chip : "+@boardTotal+" ]"
  end

  #カード追加
  def actionCard
    puts "action? (1:Hit 0:Stand)"
    while 1 do
      myAct = STDIN.gets.to_i
      if myAct==1 || myAct==0 then
        #サーバーへアクション番号を返す
        return myAct
      else
        puts "please retype (1or0)"
      end
    end
  end

  #以下なごり
  def countAllReset
    @myBetCount = 0
    @myCheckCount = 0
    @myCallCount = 0
  end
  
  def betCounter(counter)
    if counter==1 then
      @myBetCount += 1
    elsif counter==0 then
      @myBetCount = 0
    end
  end

  def myBetCount
    @myBetCount
  end

  def checkCounter(counter)
    if counter==1 then
      @myCheckCount += 1
    elsif counter==0 then
      @myCheckCount = 0
    end
  end

  def myCheckCount
    @myCheckCount
  end

  def callCounter(counter)
    if counter==1 then
      @myCallCount +=1
    elsif counter==0 then
      @myCallCount = 0
    end
  end

  def myCallCount
    @myCallCount
  end
  #以上なごり

  #ベット
  def actionBet(boardBetCount,myChip,boardBet)

    #まだ賭けられていない状態
    if boardBet==0 then
      puts "action? (check[1] or bet[3])"
      while 1 do
        myBet.action = STDIN.gets.to_i
        
        #チェック
        if myBet.action==1 then
          puts "player " + @myID + " : check"
          return [myBet.action, 0]

        #ベット20
        elsif myBet.action==3 then
          #足りない場合、オールイン
          if myChip < 20 then
            myBet.chip = myChip
            puts "player " + @myID + " : bet All in " + myBet.chip
            return [myBet.action, myBet.chip]
          else
            puts "player " + @myID + " : bet 20"
            return [myBet.action, 20]
          end
        else
          puts "please retype (1or3)"
        end
      end

    #すでに賭け金がある場合
    else
      #レイズの上限設定(割と適当)
      if boardBetCount<4 then
        puts "action? (fold[0] , call[2] or raise[3])"
      else
        puts "action? (fold[0] or call[2])"
      end
      
      while 1 do
        myBet.action = STDIN.gets.to_i

        #降りる
        if myBet.action==0 then
          puts "player " + @myID + " : fold"
          return [myBet.action, 0]

        #コールする
        elsif myBet.action==2 then
          case boardBetCount
          when 1,2 then
            myBet.chip = 20
          when 3 then
            myBet.chip = 40
          when 4 then
            myBet.chip = 80
          else
            puts "ERROR : call section in Player/actionBet "
            exit(1)
          end
          
          #足りない場合、オールイン
          if myChip < myBet.chip then
            myBet.chip = myChip 
            puts "palyer " + @myID + " : call All in " + myBet.chip
          else
            puts "player " + @myID + " : call " + myBet.chip
          end
          return [myBet.action,myBet.chip]

        #レイズする(制限設定してるけど適当)
        elsif myBet.action==3 && boardBetCount<4 then

          case boardBetCount
          when 1 then
            myBet.chip = 20
          when 2 then
            myBet.chip = 60
          when 3 then
            myBet.chip = 120
          else
            puts "ERROR : raise section in Player/actionBet "
            exit(1)
          end
          #足りない場合、オールイン
          if myChip < myBet.chip then
            myBet.chip = myChip
            puts "player " + @myID + " : raise All in " + myBet.chip
          else
            puts "player " + @myID + " : raise make " + myBet.chip
          end
          return [myBet.action,myBet.chip]
          
        else
          if boardBetCount<4 then
            puts "please retype (0,2or3)"
          else
            puts "please retype (0or2)"
          end
        end
        
      end
    end
  end
end
