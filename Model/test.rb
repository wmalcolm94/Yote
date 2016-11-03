require_relative 'hand'
require_relative 'board'
require_relative 'player'
require_relative 'cell'
require_relative 'piece'
require_relative 'game'

board = Board.new
player = Player.new(board, 'c')
cell = Cell.new
piece = Piece.new(player)
hand = Hand.new(player)
game = Game.new