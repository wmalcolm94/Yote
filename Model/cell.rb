require_relative 'piece'

class Cell

    @piece = nil
    
    def initialize
        @piece = nil
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