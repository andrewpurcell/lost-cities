module LostCities
  class Hand
    MAX_SIZE = 8

    attr_reader :cards

    def initialize(cards = [])
      @cards = cards
    end

    def full?
      cards.size == MAX_SIZE
    end

    def size
      cards.size
    end

    def add(card)
      cards << card
    end

    def has_card?(card)
      find_card(card) != nil
    end

    def find_card(search_card)
      cards.find { |card| search_card == card }
    end

    def remove(card)
      cards.delete_at(cards.index card)
    end
  end
end
