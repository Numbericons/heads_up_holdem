class Hand
    attr_accessor :cards
    def initialize
        @cards = []
    end

    def show
        return "#{self.cards[0].show} and #{self.cards[1].show}"
    end

    def hand_rank(board)
    end
end