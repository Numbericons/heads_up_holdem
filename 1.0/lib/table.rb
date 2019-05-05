class Table
    attr_accessor :cards, :sb, :bb, :players, :pot, :curr_player
    attr_reader :deck, :rem_players

    def initialize(players, sb = 50, bb = 100)
        @cards = []
        @deck = Deck.new
        @players = players
        @pot = 0
        @sb = sb
        @bb = bb
        @curr_player = @players[0]
    end

    def play_hand
        deal_in_players
        take_blinds
        betting_round(sb)
        if remaining_players?
            puts "*******-FLOP-*******"
            deal_flop
            show_board
            betting_round
        end
        if remaining_players?
            puts "*******-TURN-*******"
            deal_turn
            show_board
            betting_round
        end
        if remaining_players?
            puts "*******-RIVER-*******"
            deal_river
            show_board
            betting_round
        end
        self.players
    end

    def deal_in_players
        2.times { @players.each { |player| player.hand.cards << self.deck.draw } }
    end

    def take_blinds
        self.players[0].chipstack -= self.sb
        self.players[1].chipstack -= self.bb
        @pot += self.sb + self.bb
    end

    def deal_card
        self.cards << self.deck.draw
    end

    def deal_flop
        3.times { deal_card }
    end
    
    def deal_turn
        deal_card
    end
    
    def deal_river
        deal_card
    end
    
    def show_board
        print "The board is: "
        self.cards.each { |card| print "#{card.show}  " }
        puts
        puts
    end

    def betting_round(initial = 0)
        bet = p_action(initial)
        return self.pot unless bet
        self.pot+=bet + initial
        toggle_curr_player
        
        until bet == p_action(bet)
            toggle_curr_player
            bet = p_action(bet)
        end
        self.pot
    end
    
    def p_action(bet = 0)
        curr_player_pos = self.curr_player.position - 1
        to_call = self.players[curr_player_pos].action(bet)
        curr_player_pos == 0 ? opp_pos = 0 : opp_pos = 1
        unless to_call
            self.players = [self.players[opp_pos]]
            self.pot+=to_call
        end
        to_call
    end

    def toggle_curr_player
        if @curr_player == self.players[0]
            @curr_player = self.players[1]
        else
            @curr_player = self.players[0]
        end
    end

    def remaining_players?
        @players.length > 0
    end

    private
end