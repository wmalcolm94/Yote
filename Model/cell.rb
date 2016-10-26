require Piece

class Cell
    @piece = nil
    
    def initialize
    end
    
    def isOccuppied
        @piece != nil
    end

    def addPiece(piece)
        @piece = piece
    end

    def getPiece
        return @piece
    end
end