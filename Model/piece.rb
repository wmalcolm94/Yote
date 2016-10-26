require Player

class Piece
    @owner = nil
    def initialize(owner)
        @owner = owner
    end

    def isOwner(player)
        player == @owner
    end

    def getOwner
        @owner
    end
end