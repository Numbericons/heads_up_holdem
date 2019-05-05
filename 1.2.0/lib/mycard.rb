class MyCard
    DISP_SUITS = ["\u2660", "\u2661", "\u2662", "\u2663"]

    attr_reader :suit, :value
    
    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def self.to_s
        # val = self.value[0]
        # val = self.value if self.value == 10 
        "#{val} #{suit[0]}"
    end

    def show
        # val = @value[0]
        # val = @value if value.class == Integer
        "#{value}#{convert_suit}"
    end

    def convert_suit
        case self.suit
        when "S"
            DISP_SUITS[0]
        when "H"
            DISP_SUITS[1]
        when "D"
            DISP_SUITS[2]
        when "C"
            DISP_SUITS[3]
        end
    end
end