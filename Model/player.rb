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
                        
                        if dest_cell.isOccupied()
                            puts "That cell is occupied!"
                        elsif @board.canMove(src_coords, dest_coords)
                            @board.jump(src_coords, dest_coords)
                            take = false
                            
                            puts "Select which piece you'd like to take: "

                            while !take
                                take_coords = selectCell()
                                take_cell = @board.cells[take_coords[0]][take_coords[1]]
                                
                                if take_cell.isOccupied() and !@board.validateOwner(take_coords, self)
                                    @board.takePiece(take_coords)
                                    take = true
                                else
                                    puts "No valid piece to take from that location."
                                end
                            end

                            valid = true
                        elsif @board.canMove(src_coords, dest_coords)
                            @board.move(src_coords, dest_coords)
                            valid = true
                        else
                            puts "That cell is too far away!"
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
