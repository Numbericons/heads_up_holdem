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
            betting_round unless self.players.all? { |player| player.chipstack == 0 }
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
        determine_winner
    end

    def determine_winner
        debugger
        p1_hand = hand_to_str(self.players[0])# if self.players[0]
        p2_hand = hand_to_str(self.players[1])# if self.players[1]
        if self.players[1].folded == true || p1_hand > p2_hand
            puts "Seat #{self.players[0].seat} wins the pot of #{self.pot}!"
            return [self.players[0].seat]
        elsif self.players[0].folded == true || p1_hand < p2_hand
            puts "Seat #{self.players[1].seat} wins the pot of #{self.pot}!"
            return [self.players[1].seat]
        else
            puts "This hand resulted in a tie. Splitting the pot of #{self.pot}!"
            return [self.players[0].seat, self.players[1].seat]
        end
    end
    
    def hand_to_str(player)
        player_hand = player.hand.cards.map { |card| "#{card.value}#{card.suit}"}
        player_hand = (player_hand + self.cards.map { |card| "#{card.value}#{card.suit}"}).join(" ")
        PokerHand.new(player_hand)
    end

    def deal_in_players
        2.times { @players.each { |player| player.hand.cards << self.deck.draw } }
    end

    def take_blinds
        self.players[0].chipstack -= self.sb
        self.players[0].chips_in_pot += self.sb
        self.players[1].chipstack -= self.bb
        self.players[1].chips_in_pot += self.bb
        @pot += self.sb + self.bb
    end

    def deal_card
        self.cards << self.deck.draw
    end

    def deal_flop
        self.curr_player = @players[1]
        3.times { deal_card }
    end
    
    def deal_turn
        self.curr_player = @players[1]
        deal_card
    end
    
    def deal_river
        self.curr_player = @players[1]
        deal_card
    end
    
    def show_board
        print "The board is: ".green
        self.cards.each { |card| print "#{card.show}  " }
        puts
        puts
    end

    def betting_round(if_sb = 0)
        show_pot
        fst_bet = p_action(if_sb, if_sb)
        return self.pot unless fst_bet
        self.pot+=fst_bet[0]# + if_sb
        toggle_curr_player
        show_pot
        prev_bet = p_action(fst_bet[0] - if_sb)
        return self.pot unless prev_bet
        self.pot+=prev_bet[0]# - if_sb
        self.pot+=fst_bet[0] if prev_bet[1] == 'raise' && if_sb > 0
        # until bet == p_action(bet)
        resolve_add_bets(prev_bet)
        self.pot
    end
    
    def resolve_add_bets(prev_bet)
        self.pot+=prev_bet[0] if prev_bet[1].start_with?('ra')# || prev_bet[1].start_with?('ca')
        until self.players[0].chips_in_pot == self.players[1].chips_in_pot
            debugger
            show_pot
            toggle_curr_player
            bet = p_action(prev_bet[0])
            self.pot+=prev_bet[0] if bet[1].start_with?('ra')
            self.pot+=bet[0] if bet
        end
    end
    
    def show_pot
        puts "The pot is #{self.pot}.".red
    end
    
    def p_action(bet = 0, sb = 0)
        curr_player_pos = self.curr_player.position - 1
        to_call = self.players[curr_player_pos].action(bet, sb)
        curr_player_pos == 0 ? opp_pos = 0 : opp_pos = 1

        self.players[curr_player_pos].folded = true unless to_call
        #     self.players = [self.players[opp_pos]]
        #     # self.pot+=to_call
        # end
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
        # @players.length > 0
        return nil if self.players[0].nil? || self.players[0].folded == true
        return nil if self.players[1].nil? || self.players[1].folded == true
        true
    end

    private
end