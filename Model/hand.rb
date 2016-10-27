require_relative 'piece'
require_relative 'player'

class Hand
    pieces = []

    def constructor(owner)
        for i in 0..12
            @pieces[i] = Piece.new(owner)
        end
    end

    def removePiece 
        @pieces.pop
    end

    def getCount
        @pieces.length
    end
end