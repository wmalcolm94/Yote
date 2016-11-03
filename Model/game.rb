require_relative 'player'
require_relative 'board'

class Game
    turn = 0
    board = nil
    player1 = nil
    player2 = nil
    
    def initialize
        @turn = 0
        @board = Board.new
        @player_1 = Player.new(@board, 'O')
        @player_2 = Player.new(@board, 'X')
    end
    
    def play
        # Single turn manager and turn counter change
        # Since the game is a hotseat, the only difference will be which player is used for different functions based on the turn, and otherwise loops
        
        begin
            @turn += 1
            
            # Print out all positions of all pieces
            @board.printBoard
            
            # Ask the player for input
            # Use said input in @board.makeChoice(array[2])
            
        end until(isOver)
        
        # Print winner output based on turn odd or even
    end
    
    def isOver
        (@board.countPlayerPieces(@player_1) == 0 || @board.countPlayerPieces(@player_2) == 0)
    end
end