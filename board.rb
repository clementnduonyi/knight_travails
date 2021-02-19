#require_relative "script"

class Board
    attr_accessor :aim

    def initialize(aim = [rand(8), rand(8)])
        @board = Array.new(8) {Array.new(8)}
        @aim = aim
        @board[aim[0]][aim[1]] = "*"
        @indicators = []
    end

    def knight_trail(knight)
        @board[knight.square[0]][knight.square[1]] = knight.token
    end

    def point_indicator(points)
        points.each_with_index do |point, idx|
            if @board[point[0]][point[1]].nil?
                @board[point[0]][point[1]] = idx
                @indicators << point
            end
        end
    end

    def reset
        @indicators.each do |point|
            @board[point[0]][point[1]] = 0
        end
        @indicators = []
    end

    
    def pretty_print
        puts "   ┬───┬───┬───┬───┬───┬───┬───┬───┐"
        @board.each_with_index do |row, i|
            print " #{8 - i} │"
            row.each do |value|
                if value.nil?
                    print "   │"
                elsif value.to_s.length > 1
                    print "#{value} │"
                else
                    print " #{value} │"
                end
            end
            puts; puts "   ┼───┼───┼───┼───┼───┼───┼───┼───┤"
        end
        puts "     A   B   C   D   E   F   G   H"
        reset
    end
end

