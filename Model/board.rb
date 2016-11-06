require_relative 'cell'
require_relative 'player'
require_relative 'piece'

class Board  
    
    def initialize
        @cells = Array.new(5) {Array.new(6)}

        @cells.each_index do |x|
            @cells[x].each_index do |y|
                @cells[x][y] = Cell.new
            end
        end
    end
    
    #in this method owner is an instance of the Player class
        
    #repurposed to fetch a cell
    def makeChoice(src_cell)
        return @cells[src_cell[0]][src_cell[1]]
    end

    #piece in this method is an instance of the piece class (clearly but you never know)
    def placePiece(dest_cell, piece)
        @cells[dest_cell[0]][dest_cell[1]].addPiece(piece) 
    end

    def takePiece(dest_cell)
        #is this not redundant?
        @cells[dest_cell[0]][dest_cell[1]].removePiece()
    end
   
    #in this method owner is an instance of the player class
    def validateOwner(dest_cell, owner)
        @cells[dest_cell[0]][dest_cell[1]].getPiece().isOwner(player)
    end
    
    def isOccupied(dest_cell)
        @cells[dest_cell[0]][dest_cell[1]].isOccupied
    end

    def printBoard
        #Prints the board to the terminal
        puts "  A B C D E F"
        @cells.each_index do |x|
            string = (x+1).to_s + " "
            @cells[x].each_index do |y|
                if(@cells[x][y].isOccupied)
                   temp = @cells[x][y].getPiece()
                   player = temp.getOwner()
                   string += player.getSymbol() + " "
                else
                    string += "_ "
                end
            end
            puts string
        end
    end
    
    def countPlayerPieces(owner)
        count = owner.getHandCount()
        
        @cells.each_index do |x|
            x.each_index do |y|
                if@cells[x][y].isOccupied()
                    if @cells[x][y].getPiece().isOwner(owner)
                        count +=1
                    end
                end
            end
        end
        return count
    end

    
    private

    def getAdjacent(center)
        adjacent = [[center[0]-1,center[1]],[center[0]+1,center[1]],[center[0],center[1]-1],center[0],center[1]+1]
        adjacent
    end
end

    #for all the following src_cell and dest_cell should be a integer array of size 2
    def jump(src_cell, dest_cell)
        
        temp = @cells[src_cell[0]][src_cell[1]].removePiece()
        @cells[dest_cell[0]][dest_cell[1]].removePiece()
        @cells[dest_cell[0]][dest_cell[1]].addPiece(temp)
    
    end

    def move(src_cell, dest_cell)
        
        temp = @cells[src_cell[0][src_cell[1]]].removePiece()
        @cells[dest_cell[0]][dest_cell[1]].addPiece(temp)

    end

    def canJump(src_cell)
        x_adjacent = [1,-1,0,0]
        y_adjacent = [0,0,1,-1]

        for i in x_adjacent.length
            if(@cells[src_cell[0] +x_adjacent[i]][src_cells[1]+ y_adjacent[i]].isOccupied)
                if(@cells[src_cells[0] +x_adjacent[i]+x_adjacent[i]][src_cells[1]+y_adjacent[i]+y_adjacent[i]])
                    return true
                end
            end
        end
        return false
    end

    def canMove(src_cell)
        adjacent = getAdjacent(src_cell)

        for i in adjacent.length
            if(@cells[adjacent[i][0]][adjacent[i][1]].isOccupied)
            else
                return true
            end
        end

        false
    end
