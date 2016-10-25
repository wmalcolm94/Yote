require Board
require hand

class Player
    @board = nil
    @hand = nil

    def initialize(Board board)
        @board = board
    end

    def takeTurn
    end

    def selectCell
    end
end