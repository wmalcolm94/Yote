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
            
            if(@turn % 2 == 1)
                puts "Player 1's turn"
                player_1.takeTurn()
            else
                puts "Player 2's turn"
                player_2.takeTurn()
            end
            
        end until(isOver)
        
        @board.printBoard
        
        if(@board.countPlayerPieces(@player_1) == 0)
            puts "Player 2 wins"
        elsif(@board.countPlayerPieces(@player_1) == 0)
            puts "Player 1 wins"
        else
            puts "The game is a draw"
        end
    end
    
    def isOver
        (@board.countPlayerPieces(@player_1) == 0 || @board.countPlayerPieces(@player_2) == 0 || (@board.countPlayerPieces(@player_1) <= 0 && @board.countPlayerPieces(@player_2) <= 3 && @player_1.getHandCount == 0 && @player_2.getHandCount == 0))
    end
end