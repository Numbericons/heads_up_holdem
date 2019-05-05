class HumanPlayer
    attr_accessor :seat, :position, :hand, :chipstack, :folded, :chips_in_pot
    attr_reader 

    def initialize(seat, position, chipstack)
        @seat = seat
        @position = position
        @hand = Hand.new
        @chipstack = chipstack
        @folded = false
        @chips_in_pot = 0
    end
    
    def action(to_call, sb = 0)
        puts "Your hand is #{self.hand.show}"
        if to_call == 0
            print "Enter 'check', 'bet', or 'fold': "
        else
            puts "It costs #{to_call} to call."
            print "Enter 'call', 'raise', or 'fold': "
        end
        input = gets.chomp
        resolve_action(to_call, input, sb)
    end

    def resolve_action(to_call, input, sb)
        return 0 if input.start_with?('check')
        wager = input.split[1].to_i
        if input.start_with?('call')
            self.chipstack-=to_call
            self.chips_in_pot+=to_call
            return to_call
        end
        if input.start_with?('bet')  #logic to check all ins
            # wager = get_wager_raise(input)
            self.chipstack = self.chipstack - wager
            self.chips_in_pot+=wager - sb
            return wager
        end
        if input.start_with?('raise') #logic to check all ins
            # raise = get_bet_raise(input)
            self.chipstack-=wager + sb
            self.chips_in_pot+=wager - sb
            return wager - to_call
        end
        if input.start_with?('fold')
            self.folded = true
            return nil
        end
    end
    
    # def get_bet_raise(input)
    #     if input == 'bet'
    #         puts "How much do you want to bet?"
    #         return gets.chomp.to_i
    #     elsif input == 'raise'
    #         puts "How much do you want to raise?"
    #         return gets.chomp.to_i
    #     else
    #         return nil
    #     end
    # end
end