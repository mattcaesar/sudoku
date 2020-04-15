require_relative 'board.rb'
require_relative 'tile.rb'
require 'byebug'

class Game

    def initialize(file_name)
        @board = Board.new(file_name)
    end

    def valid_pos?(pos)
        @row = pos[0].to_i
        @col = pos[1].to_i
        
        if @row < 9 && @col < 9
            return true if @board[@row, @col].status == 'not given'
        end
        false
    end

    def valid_value?(value)
        if value > 9 || value < 1
            return false
        end
        true
    end

    def pos_prompt
        puts 'Enter a position, from 0 to 8, in the form of row, col'
        @pos = gets.chomp.split(',')
    end

    def value_prompt
        puts 'Enter a value for that position'
        @value = gets.chomp.to_i   
    end

    def play
        until @board.solved?
            system('clear')
            @board.render         
            
            # debugger
            self.pos_prompt

            if valid_pos?(@pos)
                self.value_prompt 
            else
                puts "\nInvalid position, tile already given or row/col is larger than 8. Try again!"
                sleep(2)
                self.play               
            end

            if valid_value?(@value)
                @board[@row, @col] = @value
            else
                puts 'Invalid value, enter any value from 1 to 9'
                sleep(2)
                self.play 
            end
        end
        system('clear')
        @board.render  
        puts "\nWinner!"
        puts
    end

end

game = Game.new('./puzzles/sudoku1.txt')
game.play