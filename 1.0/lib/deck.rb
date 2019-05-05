require_relative 'card.rb'
require 'colorize'

class Deck
    # SUITS = ["Spades", "Hearts", "Diamond", "Club"]
    SUITS = ["\u2660", "\u2661", "\u2662", "\u2663"]
    VALUES = (2..10).to_a
    ROYALS = ["Jack", "Queen", "King", "Ace"]
    ROYALS.each { |royal| VALUES << royal }

    def self.random_deck
        deck = []
        SUITS.each do |suit|
            VALUES.each do |value|
                # deck << [value, suit]
                deck << Card.new(value, suit)
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