# main.rb : main program
#

$:.unshift File.dirname(__FILE__)

require 'game.rb'

game = Game.new

game.run
