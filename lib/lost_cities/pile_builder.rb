module LostCities
  class PileBuilder
    attr_reader :suits, :players

    def initialize(suits, players)
      @suits = suits
      @players = players
    end

    def build
      players
        .map { |player| [player, piles_for_suits(Pile::PlayerPile)] }
        .to_h
        .merge(discard_piles)
    end

    def discard_piles
      { discard: piles_for_suits(Pile::DiscardPile) }
    end

    def piles_for_suits(pile_class)
      suits.map { |suit| pile_class.new suit }
    end
  end
end
