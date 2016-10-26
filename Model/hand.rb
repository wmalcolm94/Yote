require_relative 'piece'
require_relative 'player'

class Hand
    pieces = []

    def initialize(owner)
        for i in 0..12
            pieces[i] = Piece.new
        end
    end

    def removePiece 
        pieces.pop
    end

    def getCount
        pieces.length
    end
end