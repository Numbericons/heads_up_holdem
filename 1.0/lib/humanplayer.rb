class HumanPlayer
    attr_accessor :seat, :position, :hand, :chipstack, :folded
    attr_reader 

    def initialize(seat, position, chipstack)
        @seat = seat
        @position = position
        @hand = Hand.new
        @chipstack = chipstack
        @folded = false
    end
    
    def action(to_call)
        puts "Your hand is #{self.hand.show}"
        if to_call == 0
            print "Enter 'check', 'bet', or 'fold': "
        else
            puts "It costs #{to_call} to call."
            print "Enter 'call', 'raise', or 'fold': "
        end
        input = gets.chomp
        resolve_action(to_call, input)
    end

    def resolve_action(to_call, input)
        return 0 if input == 'check'
        if input == 'call'
            self.chipstack-=to_call
            return 0
        end
        if input == 'bet' #logic to check all ins
            bet = get_bet_raise(input)
            self.chipstack = self.chipstack - bet
            return bet
        end
        if input == 'raise' #logic to check all ins
            bet = get_bet_raise(input)
            raise = self.chipstack
            self.chipstack = 0
            return raise - to_call
        end
        if input == 'fold'
            self.folded = true
            return nil
        end
    end
    
    def get_bet_raise(input)
        if input == 'bet'
            puts "How much do you want to bet?"
            return gets.chomp.to_i
        elsif input == 'raise'
            puts "How much do you want to raise?"
            return gets.chomp.to_i
        else
            return nil
        end
    end
end