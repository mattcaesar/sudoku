require 'colorize'

class Tile

    attr_accessor :status, :value

    def initialize(value)
        @value = value
        @status = 'not given'

    end

    def make_given
        @status = 'given'
    end

    def change_value
        #only change value of tiles that are given
    end


end

#test
# A = Tile.new
# p A
# A.make_given
# p A