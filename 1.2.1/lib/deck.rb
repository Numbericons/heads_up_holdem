require_relative 'mycard.rb'
require 'colorize'

class Deck
    SUITS = ["S", "H", "D", "C"]
    # SUITS = ["\u2660", "\u2661", "\u2662", "\u2663"]
    VALUES = (2..9).to_a
    # ROYALS = ["Jack", "Queen", "King", "Ace"]
    ROYALS = ["T", "J", "Q", "K", "A"]
    ROYALS.each { |royal| VALUES << royal }

    def self.random_deck
        deck = []
        values = (2..9).to_a
        ROYALS.each { |royal| VALUES << royal }
        SUITS.each do |suit|
            values.each do |value|
                deck << MyCard.new(value, suit)
            end
        end
        deck.shuffle
    end

    attr_reader :deck, :cards_drawn

    def initialize(deck = Deck.random_deck)
        @deck = deck
        @cards_drawn = 0
    end

    def shuffle
        @deck = @deck.shuffle
    end

    def draw
        self.shuffle if cards_drawn % 52 == 0
        @cards_drawn+=1
        @deck.pop
    end

    def return(card)
        @deck.unshift(card)
    end
end