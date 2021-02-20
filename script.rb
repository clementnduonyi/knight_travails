require_relative "board"

class KnightMove
    attr_accessor :square, :token

    def initialize( board, square = [rand(8), rand(8), token = "♞"])
        @board = board
        @square = square
        @token = token
        update_square

    end

    def update_square
        @board.knight_trail(self)
    end

    def creat_indicators
        @board.point_indicator(creat_path)
    end

    def creat_path(spot = @square)
        path = Navigator.new(spot, @board.aim)
        closest_path = path.find
        knight_moves(closest_path)
        return closest_path
    end

    def knight_moves(path)
        path = change_path(path)
        trail = path.shift
        puts
        puts "#{@token} Starts from #{trail[0]} #{trail[1]} and finishes at #{path.last[0]} #{path.last[1]} in #{path.length-1} move(s)! See your path below:"
        until path.empty?
            trail = path.shift
            
            puts "-> #{trail[0]}  #{trail[1]}"
        end
            

        puts

        puts "Finish"

        puts

       
        

    end


    def change_path(path)
        changed = []
        path.each {|a| changed.push([(a[1] + 65).chr, 8 - a[0]])}
        changed << [(@board.aim[1] + 65).chr, 8 - @board.aim[0]]
        return changed
    end
end

class Navigator
    attr_accessor :root, :square

    TRAVAILS = [[-1,-2], [-2,-1], [-2,1], [-1,2], [1,-2], [2,-1], [2,1], [1,2]]

    def initialize(square, aim, queue = [], root = nil)
        @aim = aim
        @square = square
        @queue = queue
        @root = root
        @valid = valid_moves(square)
    end

    def find
        if @valid.include?(@aim)
            return root_tag(self).reverse
        end
        @valid.each do |spot|
            @queue << Navigator.new(spot, @aim, @queue, self)
        end
        box = @queue.shift
        box.find
    end

    def valid_moves(square = @square)
        valid = []
        moves = TRAVAILS.map{|move| [(move[0] + square[0]),(move[1] + square[1])]}
        moves.keep_if do |move|
            if open_space?(move)
                valid.push(move)
            end
            #valid
        end
    end

    def open_space?(square = @square)
        res = false
        if square.length == 2
            res = true
        elsif square[0] <  0 || square[0] > 7 || square[1] < 0 || square[1] > 7
            res = false
        end
        res
    end


    def root_tag(node, path = [])
        path << node.square

        if node.root.nil?
            return path
        end

        return root_tag(node.root, path)
    end

    
end

    board = Board.new
    knight = KnightMove.new(board)
    knight.creat_indicators
    board.pretty_print
    
    

   


