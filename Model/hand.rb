class Hand
    pieces = []

    def initialize(Player owner)
        for i in 0..12
            pieces[i] = Piece.new
        end
    end

    def removePiece 
        #which piece do you remove???
    end

    def getCount
        return pieces.length
    end
end