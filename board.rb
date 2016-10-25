class Board
  
    Cell[5][6] cells

    def jump(int[2] src_cell, int[2] dest_cell)
        temp = cells[src_cell[0]][src_cell[1]].removePiece()
        cells[dest_cell[0]][dest_cell[1]].removePiece()
        cells[dest_cell[0]][dest_cell[1]].addPiece(temp)
    end

    def move(int[2] src_cell, int[2] dest_cell)
    
    end

    def canJump(int[2] src_cell)
    
    end

    def canMove(int[2] src_cell)
    
    end

    def makeChoice(int[2] src_cell)
    
    end

    def placePiece(int[2] dest_cell, Piece piece)
    
    end

    def takePiece(int[2] dest_cell)
    
    end

    def validateOwner(int[2] dest_cell, Player owner)
    
    end

    def printBoard
    
    end

    def countPlayerPieces(Player owner)
    
    end
end
