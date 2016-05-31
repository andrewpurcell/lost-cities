module LostCities
  class Deck
    def initialize(cards)
      @cards = cards
    end

    def shuffle
      @cards.shuffle!
    end

    def draw
      @cards.shift
    end

    def cards_remaining
      @cards.count
    end

    def empty?
      @cards.empty?
    end
  end
end
