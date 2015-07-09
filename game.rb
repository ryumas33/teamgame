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
  @sum = 0

  def run
    #二枚配る
    card = @board.hit
    @sum = @sum + card.number.to_i
    puts card
    card = @board.hit
    @sum = @sum + card.number.to_i
    puts card

    #勝負するか、カードを追加するか
    while(1)
      action = @player1.actionCard
      if(action == 1)
        print "勝負します"
        print @sum
        break
      elsif(action == 0)
        print "追加します"
        card = @board.hit
        @sum = @sum + card.to_i
        puts card
      end
    end

    #p "hello"
    #myfunc
  end

  def initialize
    @my = Myfunc.new
    @player1 = Player.new
    # @player2 = Player.new
    @board = Board.new
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
