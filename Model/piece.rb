require Player

class Piece
    @owner = nil
    def initialize(Player owner)
        @owner = owner
    end

    def isOwner(Player player)
        if player == @owner
            return true
        else 
            return false
    end

    def getOwner
        return @owner
    end
end