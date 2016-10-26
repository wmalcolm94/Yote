require Cell
require Player
require Piece

class Board
  
    @cells = Cells[5][6]
        
    #for all the following src_cell and dest_cell should be a integer array of size 2
    def jump(src_cell, dest_cell)
        
        temp = cells[src_cell[0]][src_cell[1]].removePiece()
        cells[dest_cell[0]][dest_cell[1]].removePiece()
        cells[dest_cell[0]][dest_cell[1]].addPiece(temp)
    
    end

    def move(src_cell,dest_cell)
        
        temp = cells[src_cell[0][src_cell[1]]].removePiece()
        cells[dest_cell[0]][dest_cell[1]].addPiece(temp)

    end

    def canJump( src_cell)
    end

    def canMove(src_cell)
        adjacent = getAdjacent(src_cell)

        for i in adjacent.length
            if(cells[adjacent[i][0]][adjacent[i][1]].isOccupied)
            else
                return true
            end
        end

        false
    end

    def makeChoice(src_cell)
    
    end

    #piece in this method is an instance of the piece class (clearly but you never know)
    def placePiece(dest_cell, piece)
        cells[dest_cell[0]][dest_cell[1]].addPiece(piece) 
    end

    def takePiece(dest_cell)
        #is this not redundant?
        cells[dest_cell[0]][dest_cell[1]].removePiece()
    end
    #in this method owner is an instance of the player class
    def validateOwner(dest_cell,owner)
        temp = cells[dest_cell[0]][dest_cell[1]].getPiece()
        temp.isOwner(player)
    end

    def printBoard
        #i think i need more info to write this 
    end
    #in this method owner is an instance of the Player class
    def countPlayerPieces(owner)
        # well im pretty sure the design team is braindead.
        # I dont think i can write this without clarification of the nature of player
        # Maybe need new methods in player or does it really want me to call validateOwner
        # like 4 dozen times and then how do i get at their hand
        # Am i counting their hand or just the ones on the board
    
    end

    private
    def getAdjacent(center)
        adjacent = [[center[0]-1,center[1]],[center[0]+1,center[1]],[center[0],center[1]-1],center[0],center[1]+1]
        adjacent
    end
end
