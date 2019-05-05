Outline
    class Deck
    class Card
    class HoldEM
        HoldEM#initialize
            new shuffled deck
            players array
        HoldEM#play_hand
        HoldEM#deal_cards
        HoldEM#betting_round
        HoldEM#deal_flop
            sb/bb preflop/postflop positions
        HoldEM#deal_turn
        HoldEM#deal_river
    class Board
        Board#initialize
        BoardCards, Deck
        Board#deal_card

        #logic to check all ins
    class Hand
        Cards
        Hand#rank
    class HumanPlayer
        Chip Stack, Hand, position
        HumanPlayer#action
            call, fold, bet, raise
            if bet/raise, how much?
    class ComputerPlayer
        Chip Stack, Hand

Known Issues:
        preflop 
            bb option incorrectly says bet instead of raise
        Skip betting rounds when someone is broke
        check fold out early doesn't continue to resolve
        within round stop betting if someone is all in

quit
y
quit
y
pry
load 'holdem.rb'
game = HoldEM.new
game.play_hand
q
game.table.play_hand

