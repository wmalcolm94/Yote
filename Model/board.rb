require_relative 'cell'
require_relative 'player'
require_relative 'piece'

class Board  
    
    def initialize
        @cells = Array.new(5) {Array.new(6)}

        @cells.each_index do |y|
            @cells[y].each_index do |x|
                @cells[y][x] = Cell.new
            end
        end
    end
    
    #in this method owner is an instance of the Player class
        
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
        @cells[dest_cell[0]][dest_cell[1]].getPiece().isOwner(owner)
    end
    
    def isOccupied(dest_cell)
        @cells[dest_cell[0]][dest_cell[1]].isOccupied
    end

    def printBoard
        #Prints the board to the terminal
        puts "  A B C D E F"
        @cells.each_index do |y|
            string = (y+1).to_s + " "
            @cells[y].each_index do |x|
                if(@cells[y][x].isOccupied)
                   temp = @cells[y][x].getPiece()
                   player = temp.getOwner()
                   string += player.getSymbol() + " "
                else
                    string += "_ "
                end
            end
            puts string
        end
    end
    
    def countOtherPieces(owner)
        count = 0 
        @cells.each_index do |y|
            @cells[y].each_index do |x|
                if@cells[y][x].isOccupied()
                    if @cells[y][x].getPiece().isOwner(owner) == false
                        count +=1
                    end
                end
            end
        end
        return count
    end    
    
    def countPlayerPieces(owner)
        count = owner.getHandCount()
        
        @cells.each_index do |y|
            @cells[y].each_index do |x|
                if@cells[y][x].isOccupied()
                    if @cells[y][x].getPiece().isOwner(owner)
                        count +=1
                    end
                end
            end
        end
        return count
    end

    #for all the following src_cell and dest_cell should be a integer array of size 2
    def jump(src_cell, dest_cell)
        
        temp = @cells[src_cell[0]][src_cell[1]].removePiece
        
        if(src_cell[0] != dest_cell[0])
            #vertical jump
            if(src_cell[0] < dest_cell[0])
                @cells[src_cell[0]+1,src_cell[1]].removePiece
            else
                @cells[src_cell[0]-1,src_cell[1]].removePiece
            end
        else
            #horizontal jump
            if(src_cell[1] < dest_cell[1])
                @cells[src_cell[0],src_cell[1]+1].removePiece
            else
                @cells[src_cell[0],src_cell[1]-1].removePiece
            end
        end
        
        @cells[dest_cell[0]][dest_cell[1]].addPiece(temp)
    
    end

    def move(src_cell, dest_cell)
        
        temp = @cells[src_cell[0][src_cell[1]]].removePiece
        @cells[dest_cell[0]][dest_cell[1]].addPiece(temp)

    end

    def canJump(src_cell)
        y_adjacent = [0,0,1,-1]
        x_adjacent = [1,-1,0,0]

        for i in y_adjacent.length
            if(src_cell[0] +y_adjacent[i]*2 >= 0 && src_cell[0] +y_adjacent[i]*2 < @cells[0].length && src_cell[1] +x_adjacent[i]*2 >= 0 && src_cell[1] +x_adjacent[i]*2 < @cells.length)
                if(@cells[src_cell[0] +y_adjacent[i]][src_cells[1]+ x_adjacent[i]].isOccupied)
                    if(!validateOwner([src_cell[0] +y_adjacent[i]][src_cells[1]+ x_adjacent[i]], @cells[src_cell[0][src_cell[1]]].getOwner))
                        if(!@cells[src_cells[0] +y_adjacent[i]*2][src_cells[1]+x_adjacent[i]*2].isOccupied)
                            return true
                        end
                    end
                end
            end
        end
        return false
    end

    def canMove(src_cell)
        adjacent = getAdjacent(src_cell)

        for i in adjacent.length
            if(!@cells[adjacent[i][0]][adjacent[i][1]].isOccupied)
                return true
            end
        end

        false
    end

    def getAdjacent(center)
        adjacent = Array.new
        if(center[0]-1 >= 0)
            adjactent.push([center[0]-1,center[1]])
        end
        if(center[0]+1 < @cells.length)
            adjactent.push([center[0]+1,center[1]])
        end
        if(center[1]-1 >= 0)
            adjactent.push([center[0],center[1]-1])
        end
        if(center[1]+1 < @cells[0].length)
            adjactent.push([center[0],center[1]+1])
        end
        adjacent
    end
end
