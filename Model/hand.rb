require_relative 'piece'
require_relative 'player'

class Hand
    pieces = nil

    def initialize(owner)
        @pieces = Array.new(12)
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