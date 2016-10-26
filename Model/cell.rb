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

    def removePiece
        temp = @piece
        @piece = nil
        temp
    end

    def getPiece
        @piece
    end
end