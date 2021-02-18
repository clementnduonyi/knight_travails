class Board

    def initialize
        #knight_moves
    end
    
end

class KnightMove
    attr_accessor :open, :square, :root

    TRAVAILS = [[1, 2], [-2, -1], [-1, 2], [2, -1],[1, -2], [-2, 1], [-1, -2], [2, 1]]
    
   

    def initialize(square = [1, 0], root = nil)
        @square = square
        @root = root
        @open = open_square(@square)
    end

    def trail(array)
        @square = array
        @open = open_square(@square)
    end

    def open_square(array)
        TRAVAILS.map do |trail| 
            trails = [trail[0] + array[0], trail[1] + array[1]]
            trails.keep_if {|trail| valid?(trail)}
        end
    end

    def valid?(array)
        true if array[0].between?(1, 8) && array[1].between?(1, 8)
       
    end


    def knight_moves(start = [1, 2], finish = rand_square)
        unless Board.valid?(start) && Board.valid?(finish)
            return
        end
        @queue = [KnightMove.new(start)]
        until @queue[0].square == finish
            @queue[0].open_square.each do |trail|
                @queue << KnightMove.new(trail, @queue[0])
                @queue.shift
            end
        end

        @tracking = [@queue[0]]
        while @tracking[0].root
            @tracking.unshift(@tracking[0].root)
            puts "You made it from #{start} to #{finish} in #{@tracking.length - 1} attempts! Here is your path:"
            @tracking.each {|track| p track.square}
        end
    end
    knight_moves

    def rand_square
        [rand(8), rand(8)]
    end

end

#play = Board.new
#play.
