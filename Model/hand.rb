require Piece
require Player

class Hand
    pieces = []

    def initialize(Player owner)
        for i in 0..12
            pieces[i] = Piece.new
        end
    end

    def removePiece 
        #pieces.pop()
    end

    def getCount
        pieces.length
    end
end