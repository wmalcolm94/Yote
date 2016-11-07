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
        flag = false
        while !flag do
            src_coords = selectCell
            
            if @board.isOccupied(src_coords)
                if @board.validateOwner(src_coords, self) == self
                
                    if @board.canJump(src_coords) || @board.canMove(src_coords)
                        break
                    else 
                        flag = true
                    end
                end
            else
                if @hand.getCount() > 0
                    @board.placePiece(src_coords, @hand.removePiece())
                    return nil
                else
                    flag = true
                end
            end
        end

        flag = false
        while !flag do
            dest_coords = selectCell
            jump_count = 0
            middle_coords = nil

            if @board.isOccupied(dest_coords)
                flag = true
            else
                if @board.getAdjacentPieces(src_coords).include? dest_coords
                    @board.move(src_coords, dest_coords)
                else
                    if @board.canJump(src_coords)
                        if ((-2 < (src_coords[0] - dest_coords[0]) < 2) && (src_coords[1] - dest_coords[1] == 0) && \
                            ((-1 < dest_coords[0] < 5) && (-1 < dest_coords[1] < 6) && (-1 < src_coords[0] < 5) && (-1 < src_coords[1] < 6)))
                            
                            if(src_cell[0] != dest_cell[0])
                                #vertical jump
                                if(src_cell[0] < dest_cell[0])
                                    middle_coords = @cells[src_cell[0]+1,src_cell[1]]
                                else
                                    middle_coords = @cells[src_cell[0]-1,src_cell[1]]
                                end
                            else
                                #horizontal jump
                                if(src_cell[1] < dest_cell[1])
                                    middle_coords = @cells[src_cell[0],src_cell[1]+1]
                                else
                                    middle_coords = @cells[src_cell[0],src_cell[1]-1]
                                end
                            end

                            if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(middle_coords)))
                                @board.jump(src_coords, dest_coords)
                                jump_count += 1
                                src_coords = dest_coords
                                dest_coords = selectCell
                                
                                while (@board.canJump(dest_coords))
                                    
                                    if ((-2 < (src_coords[0] - dest_coords[0]) < 2) && (src_coords[1] - dest_coords[1] == 0) && \
                                        ((-1 < dest_coords[0] < 5) && (-1 < dest_coords[1] < 6) && (-1 < src_coords[0] < 5) && (-1 < src_coords[1] < 6)))   
                                        if(src_cell[0] != dest_cell[0])
                                            if(src_cell[0] < dest_cell[0])
                                                middle_coords = @cells[src_cell[0]+1,src_cell[1]]
                                            else
                                                middle_coords = @cells[src_cell[0]-1,src_cell[1]]
                                            end
                                        else
                                            if(src_cell[1] < dest_cell[1])
                                                middle_coords = @cells[src_cell[0],src_cell[1]+1]
                                            else
                                                middle_coords = @cells[src_cell[0],src_cell[1]-1]
                                            end
                                        end
                                        if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(middle_coords)))
                                            @board.jump(src_coords, dest_coords)
                                            jump_count += 1
                                            src_coords = dest_coords
                                            dest_coords = selectCell
                                        end
                                    end
                                end
                                for i in 0..jump_count
                                    flag = false
                                    while !flag do
                                        if @board.countOtherPieces(self) > 0
                                            take_coords = selectCell
                                            if ((!@board.validateOwner(middle_coords, self)) && (@board.isOccupied(middle_coords)))
                                                @board.takePiece(take_coords)
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
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
        #   #   #       #Continue (skip rest of code in loop)
        #   #   #No:
        #   #       #Continue (skip rest of code in loop)
        #   #No:
        #   #   #Are there pieces in player's hand?
        #   #   #Yes:
        #   #   #   #Place piece in location
        #   #   #   #Return nil
        #   #   #No:
        #   #       #Continue (skip rest of code in loop)
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
        #       #Continue (skip rest of code in loop)
        #   #No:
        #   #   #Is dest_cell in list of adjactent cells?
        #   #   #Yes:
        #   #       #Move Piece from src_cell to dest_cell
        #   #       #Break (exit loop)
        #   #   #No:
        #   #   #   #canJump?
        #   #   #   #Yes:
        #   #   #   #   #Is cell +/- 2 horizontal of src_cell XOR +/- 2 vertical of src_cell? 
        #   #   #   #       #HINT: ((-2 < src_cell[0] - dest_cell[0] < 2) AND (src_cell[1] - desk_cell[1] == 0) AND (0 >= dest_cell >= 5))
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
        #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
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
        #   #   #   #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
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
        #   #   #   #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #   #   #   #   #   #End loop
        #   #   #   #   #   #   #   #   #No:
        #   #   #   #   #   #   #   #       #Break (exit loop)
        #   #   #   #   #   #   #   #End loop
        #   #   #   #   #   #   #No:
        #   #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #   #No:
        #   #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #   #No:
        #   #   #   #       #Continue (skip rest of code in loop)
        #   #   #   #No:
        #   #   #       #Continue (skip rest of code in loop)
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
