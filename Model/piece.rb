require_relative 'player'

class Piece
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