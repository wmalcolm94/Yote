include Player
include Board

class Game
    def initialize
        @turn = 0
        @board = Board.new
        @player_1 = Player.new
        @player_2 = Player.new
        @player_1.constructor(@board)
        @player_2.constructor(@board)
    end
    
    def play
        #single turn manager and turn counter change
    end
    
    def isOver
        #check win conditions
    end
end