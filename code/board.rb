require_relative 'tile.rb'

class Board

    def initialize(file_name)
        @grid = Array.new(9) { Array.new() }
        self.populate_grid(file_name)
    end

    def populate_grid(file_name)
        File.readlines(file_name).each_with_index do |line, indx|

           line.chomp.split('').each_with_index do |val, indx2|
           
            @grid[indx][indx2] = Tile.new(val.to_i)
            @grid[indx][indx2].status = 'given' if val.to_i != 0
           end
        end
    end

    def [](row, col)
        @grid[row][col]
    end

    def []=(row, col, val)
        @grid[row][col].value = val
    end

    def render
        puts
        @grid.each_with_index do |row, indx1|
            row.each_with_index do |tile, indx2|
                print tile.value.to_s.colorize(:blue) if tile.status == 'given'
                print tile.value if tile.status == 'not given'
            print '|' if (indx2+1) % 3 == 0
            end
            puts
            print ('------------' + "\n") if (indx1+1) % 3 == 0
        end
        puts
    end

    def solved?
        if self.check_hashes_for_solved(self.three_by_threes?) && self.check_hashes_for_solved(self.rows?) && self.check_hashes_for_solved(self.columns?)
            return true
        end
        false
    end

    def check_hashes_for_solved(tile_count_hash_arr)
        tile_count_hash_arr.each do |hash|
            hash.each do |tile_val, tile_count|
                return false if tile_val == 0 || tile_count != 1
            end
        end
        true
    end

    def rows?(arr = @grid)
        row_hashes = []
        @grid.each do |row|
            row_check = Hash.new { |h, k| h[k] = 0 }
            row.each do |tile|
                row_check[tile.value] += 1
            end
            row_hashes << row_check
        end
        row_hashes
    end

    def columns?(arr = @grid)
        rows?(@grid.transpose)
    end

    def three_by_threes?
        block_hashes = Array.new(9) { Hash.new { |h, k| h[k] = 0 } }

        [*0..8].each do |row_indx|
            [*0..8].each do |col_indx|
                if row_indx < 3 && col_indx < 3
                    block_hashes[0][(@grid[row_indx][col_indx]).value] += 1
                
                elsif row_indx < 3 && col_indx < 6
                    block_hashes[1][(@grid[row_indx][col_indx]).value] += 1

                elsif row_indx < 3 && col_indx < 9
                    block_hashes[2][(@grid[row_indx][col_indx]).value] += 1                

                elsif row_indx < 6 && col_indx < 3
                    block_hashes[3][(@grid[row_indx][col_indx]).value] += 1
                
                elsif row_indx < 6 && col_indx < 6
                    block_hashes[4][(@grid[row_indx][col_indx]).value] += 1                        

                elsif row_indx < 6 && col_indx < 9
                    block_hashes[5][(@grid[row_indx][col_indx]).value] += 1

                elsif row_indx < 9 && col_indx < 3
                    block_hashes[6][(@grid[row_indx][col_indx]).value] += 1

                elsif row_indx < 9 && col_indx < 6
                    block_hashes[7][(@grid[row_indx][col_indx]).value] += 1

                elsif row_indx < 9 && col_indx < 9
                    block_hashes[8][(@grid[row_indx][col_indx]).value] += 1
                end
            end
        end

        block_hashes
    end

end

#test
# board1 = Board.new('./puzzles/sudoku1.txt')
# board.render
# p board.solved?

# board2 = Board.new('./puzzles/sudoku1_solved.txt')
# board2.render
# p board1.check_hashes_for_solved(board1.rows?)
# p board1.check_hashes_for_solved(board1.columns?)
# p board1.check_hashes_for_solved(board1.three_by_threes?)
# board1.solved?