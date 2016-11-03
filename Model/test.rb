require_relative 'hand'
require_relative 'board'
require_relative 'player'
require_relative 'cell'
require_relative 'piece'
require_relative 'game'

hand = Hand.new
board = Board.new
player = Player.new
cell = Cell.new
piece = Piece.new(player)
game = Game.new