require Player

class Piece
    @owner = nil
    def initialize(Player owner)
        @owner = owner
    end

    def isOwner(Player player)
        player == @owner
    end

    def getOwner
        @owner
    end
end