require_relative 'player'

class Piece
    @owner = nil
    
    def constructor(owner)
        @owner = owner
    end

    def isOwner(player)
        player == @owner
    end

    def getOwner
        @owner
    end
end