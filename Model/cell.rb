require_relative 'piece'

class Cell
    def initialize
        @piece = nil
    end

    def isOccupied
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