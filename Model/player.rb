require_relative 'board'
require_relative 'hand'

class Player
	board = nil
	hand = nil

    def constructor(board)
        @board = board
        @hand = Hand.new
        @hand.constructor(self)
    end

    def takeTurn
    	#This method will be used to start a player’s turn. This will be called every time
		#either player’s turn starts.
		
		#The player gets to choose their turn.
		#Selecting an empty cell will automatically place a piece.
		#Selecting a friendly occupied cell will transition into moving mode.
		#The player has the choice of moving to an empty space or jumping over an
		#enemy piece (if available).

		#WTF?

        #Take turn should prompt the user to act. This is where you should ask them to select a cell.
        #You could also validate that this cell is either free or contains a piece belonging to the player.

        flag = false

        puts "Enter which cell you wish to select: "

        while !flag do
            src_coords = selectCell()
            src_cell = @board.cells[src_coords[0]][src_coords[1]]
            
            if src_cell.isOccupied()
                if src_cell.piece.isOwner(self)
                    valid = false
                    
                    while !valid do
                        puts "Enter which cell you'd like to move to: "
                        
                        dest_coords = selectCell()
                        dest_cell = @board.cells[dest_coords[0]][dest_coords[1]]

                        #apparently make choice handles most of this
                        #some private methods in board could do this
                        
                        if dest_cell.isOccupied()
                            puts "That cell is occupied!"
                        elsif #not adjacent and not jump
                            puts "That cell is too far away!"
                        elsif #is jump
                            #take piece
                            valid = true
                        else
                            #move piece
                            valid = true
                        end

                        @board.makeChoice()
                        flag = true
                    end
                else
                    puts "That isn't your piece!"
                end
            elsif !src_cell.isOccupied()
                src_cell.addPiece(@hand.removePiece())
                flag = true
            end
        end
    end

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
    	input
    end
end