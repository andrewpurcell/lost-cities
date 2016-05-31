require_relative 'lib/lost_cities'
require 'pry'

game = LostCities::Game.new(%w/Andrew Christina/)
game.play
