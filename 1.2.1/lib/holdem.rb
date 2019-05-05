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
    attr_reader :deck, :players, :dealer_pos, :start_chips, :table, :players
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

    def toggle_players
        self.players.push(self.players.shift)
        self.players.each do |player|
            if player.position == 1
                player.position = 2
            else
                player.position = 1
            end
        end
    end

    def reset_player_vars
        self.players.each { |player| player.hand = Hand.new }
        self.players.each { |player| player.chips_in_pot = 0 }
        self.players.each { |player| player.folded = false }
    end
end

if __FILE__ == $PROGRAM_NAME
    game = HoldEM.new
    until game.players.any? { |player| player.chipstack == 0 }
        game.play_hand
        game.toggle_players
    end
    if game.players[0].chipstack == 0
        "The Player in Seat 2 has won the match!"
    else
        "The Player in Seat 1 has won the match!"
    end
end