class Cell
    @piece = nil
    def initialize
    end
    
    def isOccuppied
        if @piece == nil
            return false
        else
            return true
    end

    def addPiece(Piece piece)
        @piece = piece
    end

    def getPiece
        return piece
    end
end