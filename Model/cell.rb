require Piece

class Cell
    @piece = nil
    
    def isOccuppied
        @piece != nil
    end

    def addPiece(piece)
        @piece = piece
    end

    def removePiece
        temp = @piece
        @piece = nil
        temp
    end

    def getPiece
        @piece
    end
end