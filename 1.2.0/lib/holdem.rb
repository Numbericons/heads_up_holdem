require_relative 'deck.rb'
require_relative 'humanplayer.rb'
require_relative 'table.rb'
require_relative 'hand.rb'
require_relative 'mycard.rb'
require 'rubygems'
require 'ruby-poker'
require 'byebug'
require 'colorize'

class HoldEM
    attr_reader :deck, :players, :dealer_pos, :start_chips, :table
    def initialize(start_chips = 1500)
        @start_chips = start_chips
        @players = [HumanPlayer.new(1, 1, start_chips), HumanPlayer.new(2, 2, start_chips)]
        @dealer_pos = 0
    end

    def play_hand
        @dealer_pos+=1
        @table = Table.new(self.players)
        @table.play_hand
    end
end

# game = HoldEM.new
# game.play_hand

if __FILE__ == $PROGRAM_NAME
    game = HoldEM.new
    game.play_hand
    game.table.play_hand
end