module LostCities
  class Card
    include Comparable

    attr_reader :suit, :value

    def initialize(suit, value, investor = false)
      @suit, @value, @investor = suit, value, investor
    end

    def self.value_card(suit, value)
      new suit, value
    end

    def self.investor(suit)
      new suit, 0, true
    end

    def investor?
      @investor
    end

    def <=>(other_card)
      return 1 if other_card.nil?

      [suit, value.to_i] <=> [other_card.suit, other_card.value.to_i]
    end

    def to_s
      "#{suit} #{investor? ? 'Investor' : value}"
    end
  end
end

