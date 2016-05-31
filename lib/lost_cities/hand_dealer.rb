module LostCities
  class HandDealer
    def self.deal_to_players(players, deck)
      players.map { |player| [player, deal_single_hand(deck)] }.to_h
    end

    def self.deal_single_hand(deck)
      Hand.new.tap { |hand| hand.add(deck.draw) until hand.full? }
    end
  end
end
