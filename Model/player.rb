require_relative 'board'
require_relative 'hand'

class Player
	board = nil
	hand = nil

    def constructor(board)
        @board = board
        @hand = Hand.new(self)
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