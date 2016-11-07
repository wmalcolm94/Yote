require_relative 'board'
require_relative 'hand'

class Player
    def initialize(board, symbol)
        @board = board
        @hand = Hand.new(self)
        @symbol = symbol
    end

    def getSymbol
        @symbol
    end

    def getHandCount
        @hand.getCount()
    end

    def takeTurn
        puts "Enter which cell you wish to select: "
        
        while true do
            src_coords = selectCell
            
            if @board.isOccupied(src_coords)
                if @board.validateOwner(src_coords, self)
                    if @board.canJump(src_coords) || @board.canMove(src_coords)
                        break
                    else 
                        puts "That piece can't move or jump."
                        next
                    end
                else
                    puts "That piece doesn't belong to you."
                end
            else
                if @hand.getCount() > 0
                    puts "Piece Placed."
                    @board.placePiece(src_coords, @hand.removePiece())
                    return nil
                else
                    puts "No pieces left in hand."
                    next
                end
            end
        end

        puts "Enter which cell you'd like to move or jump to: "
        
        while true do
            dest_coords = selectCell
            jump_count = 0
            middle_coords = nil

            if @board.isOccupied(dest_coords)
                puts "That position is occupied."
                next
            else
                if @board.getAdjacent(src_coords).include? dest_coords
                    @board.move(src_coords, dest_coords)
                    puts "Piece moved."
                    break
                else
                    if @board.canJump(src_coords)
                        if (src_coords[0] - dest_coords[0] >= -2 && src_coords[0] - dest_coords[0] <= 2 && src_coords[1] - dest_coords[1] == 0) || \
                                (src_coords[1] - dest_coords[1] >= -2 && src_coords[1] - dest_coords[1] <= 2 && src_coords[0] - dest_coords[0] == 0)
                            
                            if(src_coords[0] != dest_coords[0])
                                #vertical jump
                                if(src_coords[0] < dest_coords[0])
                                    middle_coords = [src_coords[0]+1,src_coords[1]]
                                else
                                    middle_coords = [src_coords[0]-1,src_coords[1]]
                                end
                            else
                                #horizontal jump
                                if(src_coords[1] < dest_coords[1])
                                    middle_coords = [src_coords[0],src_coords[1]+1]
                                else
                                    middle_coords = [src_coords[0],src_coords[1]-1]
                                end
                            end

                            if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(middle_coords)))
                                @board.jump(src_coords, dest_coords)
                                jump_count += 1
                                src_coords = dest_coords
                                puts "Piece jumped."
                                
                                if(@board.canJump(dest_coords))
                                    puts "Select a position to jump again to: "
                                end
                                
                                while (@board.canJump(dest_coords))
                                    if src_coords != dest_coords
                                        puts "Select a position to jump again to: "
                                    end
                                    src_coords = dest_coords
                                    new_dest_coords = selectCell
                                    
                                    if src_coords == new_dest_coords
                                        puts "that's your current new position."
                                        next
                                    end
                                    
                                    if (src_coords[0] - new_dest_coords[0] >= -2 && src_coords[0] - new_dest_coords[0] <= 2 && src_coords[1] - new_dest_coords[1] == 0) || \
                                            (src_coords[1] - new_dest_coords[1] >= -2 && src_coords[1] - new_dest_coords[1] <= 2 && src_coords[0] - new_dest_coords[0] == 0)
                                        if(src_coords[0] != new_dest_coords[0])
                                            if(src_coords[0] < new_dest_coords[0])
                                                middle_coords = [src_coords[0]+1,src_coords[1]]
                                            else
                                                middle_coords = [src_coords[0]-1,src_coords[1]]
                                            end
                                        else
                                            if(src_coords[1] < new_dest_coords[1])
                                                middle_coords = [src_coords[0],src_coords[1]+1]
                                            else
                                                middle_coords = [src_coords[0],src_coords[1]-1]
                                            end
                                        end
                                        if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(middle_coords)))
                                            dest_coords = new_dest_coords
                                            @board.jump(src_coords, dest_coords)
                                            jump_count += 1
                                            puts "Piece jumped."
                                        else
                                            puts "There isn't an enemy's piece to jump."
                                            next
                                        end
                                    else
                                        puts "That isn't a position you can jump to."
                                        next
                                    end
                                end
                            else
                                puts "There isn't an enemy's piece to jump."
                                next
                            end
                        else
                            puts "Your piece cannot move or jump there."
                            next
                        end
                    else
                        puts "Your piece cannot move or jump there."
                        next
                    end
                end
                
            end
            i = 0
            while i < jump_count
                if @board.countOtherPieces(self) > 0
                    puts "Enter an opponent's piece to capture: "
                    while true do
                        take_coords = selectCell
                        if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(take_coords)))
                            @board.takePiece(take_coords)
                            break
                        else
                            puts "That is not a valid selection."
                        end
                    end
                else
                    puts "Your opponent has no pieces to capture."
                    break
                end
                i+=1;
            end
            
            return nil
        end
    end

        #Loop forever
        #
        #   #Select cell (src_cell)
        #
        #   #Is src_cell occupied?
        #   #Yes:
        #   #   #Is the owner self?
        #   #   #Yes:
        #   #   #   #piece canMove or canJump?
        #   #   #   #Yes:
        #   #   #       #Break (exit loop)
        #   #   #   #No:
        #   #   #       #next (skip rest of code in loop)
        #   #   #No:
        #   #       #next (skip rest of code in loop)
        #   #No:
        #   #   #Are there pieces in player's hand?
        #   #   #Yes:
        #   #   #   #Place piece in location
        #   #   #   #Return nil
        #   #   #No:
        #   #       #next (skip rest of code in loop)
        #   #
        #End loop
        
        #HINT: Valid position selected. Beginning second position selection
        
        #jumpcount = 0
        
        #Loop forever
        #
        #   #Select cell (dest_cell)
        #
        #   #Is dest_cell occupied?
        #   #Yes:
        #       #next (skip rest of code in loop)
        #   #No:
        #   #   #Is dest_cell in list of adjactent cells?
        #   #   #Yes:
        #   #       #Move Piece from src_cell to dest_cell
        #   #       #Break (exit loop)
        #   #   #No:
        #   #   #   #canJump?
        #   #   #   #Yes:
        #   #   #   #   #Is cell +/- 2 horizontal of src_cell XOR +/- 2 vertical of src_cell? 
        #   #   #   #       #HINT: ((-2 < src_cell[0] - dest_cell[0] < 2) AND (src_cell[1] - desk_cell[1] == 0) AND (0 >= dest_cell[0] >= 5))
        #   #   #   #           #Psudo code of the check for vertical.
        #   #   #   #   #Yes:
        #   #   #   #   #   #Is cell between src_cell and dest_cell occupied?
        #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #Is it occupied by a non-friendly piece?
        #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #Jump piece from src_cell to dest_cell
        #   #   #   #   #   #   #   #jumpcount++
        #   #   #   #   #   #   #
        #   #   #   #   #   #   #   #While canJump(dest_cell):
        #   #   #   #   #   #   #   #   #src_cell = dest_cell
        #   #   #   #   #   #   #   #   #Select cell (new_dest_cell)
        #   #   #   #   #   #   #   #
        #   #   #   #   #   #   #   #   #Is new_dest_cell occupied?
        #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #Is cell +/- 2 horizontal of src_cell XOR +/- 2 vertical of src_cell? (see previous time used)
        #   #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #   #Is space between src_cell and new_dest_cell occupied?
        #   #   #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #   #   #Is the occupying piece non-friendly?
        #   #   #   #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #   #   #   #dest_cell = new_dest_cell
        #   #   #   #   #   #   #   #   #   #   #   #   #Jump from src_cell to dest_cell
        #   #   #   #   #   #   #   #   #   #   #   #   #jumpcount++
        #   #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #End loop
        #   #   #   #   #   #   #
        #   #   #   #   #   #   #   #Loop for jumpcount times
        #   #   #   #   #   #   #   #   #Does opponent have pieces on the board left?
        #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #Loop Forever
        #   #   #   #   #   #   #   #   #   #   #Select cell (take_cell)
        #   #   #   #   #   #   #   #   #   #   #Is take_cell occupied?
        #   #   #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #   #   #Is it occupied by a non-friendly piece?
        #   #   #   #   #   #   #   #   #   #   #   #Yes:
        #   #   #   #   #   #   #   #   #   #   #   #   #Take piece in take_cell off board
        #   #   #   #   #   #   #   #   #   #   #   #   #Break (exit loop)
        #   #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #End loop
        #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #       #Break (exit loop)
        #   #   #   #   #   #   #   #End loop
        #   #   #   #   #   #   #No:
        #   #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #   #No:
        #   #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #   #No:
        #   #   #   #       #next (skip rest of code in loop)
        #   #   #   #No:
        #   #   #       #next (skip rest of code in loop)
        #   #   #
        #End loop
                    
        
        
# === OLD CODE ===
        
#    	flag = false
#
#        puts "Enter which cell you wish to select: "
#
#        while !flag do
#            src_coords = selectCell
#            
#            if @board.isOccupied(src_coords)
#                if @board.validateOwner(src_coords, self)
#                    valid = false
#                    
#                    while !valid do
#                        puts "Enter which cell you'd like to move to: "
#                        
#                        dest_coords = selectCell
#                        
#                        if @board.isOccupied(dest_coords)
#                            puts "That cell is occupied!"
#                        elsif @board.canMove(src_coords, dest_coords)
#                            @board.jump(src_coords, dest_coords)
#                            take = false
#                            
#                            puts "Select which piece you'd like to take: "
#
#                            while !take
#                                take_coords = selectCell
#                                
#                                if @board.isOccupied(take_coords) and !@board.validateOwner(take_coords, self)
#                                    @board.takePiece(take_coords)
#                                    take = true
#                                else
#                                    puts "No valid piece to take from that location."
#                                end
#                            end
#
#                            valid = true
#                        elsif @board.canMove(src_coords, dest_coords)
#                            @board.move(src_coords, dest_coords)
#                            valid = true
#                        else
#                            puts "That cell is too far away!"
#                        end
#
#                        flag = true
#                    end
#                else
#                    puts "That isn't your piece!"
#                end
#            elsif !@board.isOccupied(src_coords)
#                @board.placePiece(src_coords, @hand.removePiece())
#                flag = true
#            end
#        end
#    end

    def selectCell
    	flag  = false
    	input = nil
    	
    	while !flag do
    		input = gets.upcase.chomp.chars

    		if input.length != 2
    			puts "I only accept 2 characters."
	    	elsif input[0] < 'A' or input[0] > 'F'
	    		puts "First character must be A-F."
	    	elsif input[1] < '1' or input[1] > '5'
	    		puts "Second character must be 1-5."
	    	else
	    		flag = true
    	        end

        end
    	
    	input[0] = input[0].ord - 65
    	input[1] = input[1].to_i - 1
    	input.reverse
    end

end
