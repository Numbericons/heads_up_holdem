class Card
    attr_reader :suit, :value
    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def self.to_s
        val = self.value[0]
        val = self.value if self.value == 10 
        "#{val} #{suit[0]}"
    end

    def show
        val = @value[0]
        val = @value if value.class == Integer
        "#{val}#{suit}"
    end
end