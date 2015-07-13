# -*- coding: utf-8 -*-
# game.rb : game main
#
#
#

$:.unshift File.dirname(__FILE__)

require 'myfunc.rb'
require 'player.rb'
require 'board.rb'

class Game

  def gameinitialize #初期化
    @player1_hand.clear
    @player1_sum = 0
    @player2_hand.clear
    @player2_sum = 0
    @board_bet = 0
    @BetCount = 0
  end

  def chip_check #所持金の確認
    puts "現在の所持金"
    print "player1さん:[",@board.p1chip,"]\n"
    print "player2さん:[",@board.p2chip,"]\n"
  end

  def hand_print(number, visible) #ハンドの確認
    print "player1 : "
    for hand in @player1_hand #for文でハンドをすべて表示
      if number == 2 and visible == false #player2が見るときは一枚目を[?]に
        print "[ ? ]"
        visible = true
      else
        print "[", hand , "]"
      end
    end
    puts "\n"

    print "player2 : "
    for hand in @player2_hand #for文でハンドをすべて表示
      if number == 1 and visible == false #player1が見るときは一枚目を[?]に
        print "[ ? ]"
        visible = true
      else
        print "[", hand , "]"
      end
    end
    puts "\n"
  end

  def hand_check
    #player1の確認
    puts "player1さん確認してください[ENTER]"
    temp = STDIN.gets.to_i
    hand_print( 1, false)
    puts "[ENTER]"
    temp = STDIN.gets.to_i
    print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

    puts "player2さん確認してください[ENTER]"
    temp = STDIN.gets.to_i
    hand_print( 2, false)
    puts "[ENTER]"
    temp = STDIN.gets.to_i
    print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  end

  def first_round #カードを2枚配る
    #player1の初手
    card = @board.hit
    @player1_sum += card.bjnumber
    @player1_hand.push(card.number)
    card = @board.hit
    @player1_sum += card.bjnumber
    @player1_hand.push(card.number)

    #player2の初手
    card = @board.hit
    @player2_sum += card.bjnumber
    @player2_hand.push(card.number)
    card = @board.hit
    @player2_sum += card.bjnumber
    @player2_hand.push(card.number)
  end

  def bet_round #ベットをする。
    print "場の賭け金[", @board_bet, "]\n"
    while(1)
      #player1のベット
      print "\n[player1 Bet]\n\n"
      action_bet = @player1.actionBet(@BetCount, @board.p1chip, @board_bet)
      @board.p1bet(action_bet[1])
      @board_bet += action_bet[1]
      @BetCount += 1 if action_bet[0] == 3
      print "場の賭け金[", @board_bet, "]\n"
      #call,foldで終了
      if action_bet[0] == 2
        return 0
      elsif action_bet[0] == 0
        return 1 #player1がfoldした場合
      end

      #player2のベット
      print "\n[player2 Bet]\n\n"
      action_bet = @player2.actionBet(@BetCount, @board.p2chip, @board_bet)
      @board.p2bet(action_bet[1])
      @board_bet += action_bet[1]
      @BetCount += 1 if action_bet[0] == 3
      print "場の賭け金[", @board_bet, "]\n"
      #check,call,foldで終了
      if(action_bet[0] == 1 or action_bet[0] == 2)
        return 0
      elsif action_bet[0] == 0
        return 2 #player2がfoldした場合
      end
    end
  end

  def hit_round #勝負するか、カードを追加するか
    puts "player1さん確認してください[ENTER]"
    temp = STDIN.gets.to_i
    hand_print( 1, false)
    while(1)
      action = @player1.actionCard
      if(action == 0)
        puts "この手で勝負します"
        break
      elsif(action == 1)
        puts "追加します"
        card = @board.hit
        @player1_sum += card.bjnumber
        @player1_hand.push(card.number)
        hand_print( 1, false)
      end
      if(@player1_sum > 21)
        puts "バストです"
        puts @player1_sum
        break
      end
    end
    puts "[ENTER]"
    temp = STDIN.gets.to_i
    print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"


    puts "player2さん確認してください[ENTER]"
    temp = STDIN.gets.to_i
    hand_print( 2, false)
    while(1)
      action = @player2.actionCard
      if(action == 0)
        puts "この手で勝負します"
        break
      elsif(action == 1)
        puts "追加します"
        card = @board.hit
        @player2_sum += card.bjnumber
        @player2_hand.push(card.number)
        hand_print( 2, false)
      end
      if(@player2_sum > 21)
        puts "バストです"
        puts @player2_sum
        break
      end
    end
    puts "[ENTER]"
    temp = STDIN.gets.to_i
    print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

  end

  def win #勝敗判定
    #手札の確認
    hand_print( 1, true)

    #エースがないか確認
    @player1_hand.sort!
    @player1_sum += 10 if @player1_hand[0] == 1 and (@player1_sum + 10) <= 21
    @player2_hand.sort!
    @player2_sum += 10 if @player2_hand[0] == 1 and (@player2_sum + 10) <= 21

    #勝敗を確認
    if (@player1_sum > 21 and @player2_sum > 21) or @player1_sum == @player2_sum
      puts "ドローです。"
      print "獲得金額[",@board_bet/2,"]\n"
      @board.p1get(@board_bet/2)
      @board.p2get(@board_bet/2)
    elsif @player1_sum > @player2_sum
      puts "!!!!player1 の 勝利です。!!!!"
      print "獲得金額[",@board_bet,"]\n"
      @board.p1get(@board_bet)
    else
      puts "!!!!player2 の 勝利です。!!!!"
      print "獲得金額[",@board_bet,"]\n"
      @board.p2get(@board_bet)
    end
  end

  def fold_game(fold) #foldの処理
    if fold == 1
      puts "!!!!player1 の 勝利です。!!!!"
      print "獲得金額[",@board_bet,"]\n"
      @board.p1get(@board_bet)
    else
      puts "!!!!player2 の 勝利です。!!!!"
      print "獲得金額[",@board_bet,"]\n"
      @board.p2get(@board_bet)
    end
  end

  def next? #ゲームを続けるか、終わるか
    puts "ゲームを続けますか？ Yes[0]/No[1]"
    check_next = STDIN.gets.to_i
  end

  def run
    while(1)
      #ゲームの初期化
      self.gameinitialize
      #カードを2枚配る
      self.first_round
      #ハンドの確認
      self.hand_check
      #持金の確認
      self.chip_check
      #betを決める。(bet_round)
      fold = self.bet_round
      
      if fold == 0
        #hit,standを選ぶ。(hit_round)
        self.hit_round
        #betを決める。(bet_round)
        fold = self.bet_round
      end
      #勝敗判定
      if fold == 0
        self.win
      else
        self.fold_game(fold) #foldの処理
      end
      #持金の確認
      self.chip_check
      #ゲームを続行するか判断する。
      if(@board.p1chip < 0 or @board.p2chip < 0 or self.next? == 1)
        puts "ゲームを終了します。"
        break
      end
    end
  end

  def initialize
    @my = Myfunc.new
    @player1 = Player.new
    @player1_hand = [] #@player1のハンド
    @player1_sum = 0 #player1のハンドの合計
    @player2 = Player.new
    @player2_hand = [] #@player2のハンド
    @player2_sum = 0 #player2のハンドの合計
    @board = Board.new

    @board_bet = 0 #ベット額の総計
    @BetCount = 0 #bet,raiseの回数をカウントする用
  end

  def somefunc
    p "do nothing"
  end

  def myfunc
    @my.hello
  end

  def game_loop
    while(1)
      p1move = @player1.getmove
      @board.doit(p1move)
      p "player1 win" if(@borad.is_p1win)

      p2move = @player2.getmove
      @board.doit(p2move)
      p "player1 win" if(@borad.is_p1win)

      # we can not stop ..
    end
  end

end
