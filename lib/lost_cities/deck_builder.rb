module LostCities
  class DeckBuilder
    def self.build_cards(suits, values, investors)
      suits.each_with_object([]) do |suit, deck|
        deck.concat values.map { |v| Card.value_card(suit, v) }
        deck.concat [ Card.investor(suit) ] * investors
      end
    end

    def self.build(suits = Suit.all, values = 2..10, investors = 3)
      Deck.new build_cards(suits, values, investors)
    end
  end
end
