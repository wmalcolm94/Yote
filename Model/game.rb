require_relative 'player'
require_relative 'board'

class Game
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
            puts "Pieces in hand:"
            puts "Player " + @player_1.getSymbol + ": " + @player_1.getHandCount.to_s
            puts "Player " + @player_2.getSymbol + ": " + @player_2.getHandCount.to_s
            @board.printBoard
            
            if(@turn % 2 == 1)
                puts "Player " + @player_1.getSymbol + "'s turn."
                @player_1.takeTurn
            else
                puts "Player " + @player_2.getSymbol + "'s turn."
                @player_2.takeTurn
            end
        end until isOver
        
        puts "Player " + @player_1.getSymbol + ": " + @player_1.getHandCount.to_s
        puts "Player " + @player_2.getSymbol + ": " + @player_2.getHandCount.to_s
        @board.printBoard
        
        if(@board.countPlayerPieces(@player_1) == 0)
            puts "Player " + @player_2.getSymbol + " wins."
        elsif(@board.countPlayerPieces(@player_2) == 0)
            puts "Player " + @player_1.getSymbol + " wins."
        else
            puts "The game is a draw."
        end
    end
    
    # Check if either player is completely out of pieces, or if both players have 3 or fewer pieces on the board and none in hand remaining. 
    def isOver
        (@board.countPlayerPieces(@player_1) == 0 || @board.countPlayerPieces(@player_2) == 0 || (@board.countPlayerPieces(@player_1) <= 3 && @board.countPlayerPieces(@player_2) <= 3 && @player_1.getHandCount == 0 && @player_2.getHandCount == 0))
    end
end
    
Game.new.play