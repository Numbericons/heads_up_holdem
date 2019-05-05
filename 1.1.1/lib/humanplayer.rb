class HumanPlayer
    attr_accessor :seat, :position, :hand, :chipstack, :folded, :chips_in_pot
    attr_reader
    
    # DISP_SUITS = ["\u2660", "\u2661", "\u2662", "\u2663"]

    def initialize(seat, position, chipstack)
        @seat = seat
        @position = position
        @hand = Hand.new
        @chipstack = chipstack
        @folded = false
        @chips_in_pot = 0
    end
    
    def action(to_call, sb = 0)
        puts "Seat #{self.seat}, your hand is #{self.hand.show}"
        if to_call == 0
            puts "Enter 'check', 'fold', or 'bet' followed by an amount i.e. 'bet 100'".blue
            print 'Action: '.green
        else
            puts "It costs #{to_call} to call.".green
            puts "Enter 'call', 'fold', 'raise' follow by an amount i.e. 'raise 300': ".blue
            print 'Action: '.green
        end
        input = gets.chomp
        resolve_action(to_call, input, sb)
    end

    def convert_suits
    end

    def resolve_action(to_call, input, sb)
        return [0, 'check'] if input.start_with?('ch')
        wager = input.split[1].to_i
        if input.start_with?('ca')
            self.chipstack-=to_call
            self.chips_in_pot+=to_call
            return [to_call, 'call']
        end
        if input.start_with?('bet')  #logic to check all ins
            # wager = get_wager_raise(input)
            self.chipstack = self.chipstack - wager
            self.chips_in_pot+=wager - sb
            return [wager, 'bet']
        end
        if input.start_with?('ra') #logic to check all ins
            # raise = get_bet_raise(input)
            self.chipstack-=wager + sb
            self.chips_in_pot+=wager - sb
            return [wager - to_call, 'raise']
        end
        if input.start_with?('fo')
            self.folded = true
            return nil
        end
    end
end