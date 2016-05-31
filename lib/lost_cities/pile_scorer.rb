module LostCities
  class PileScorer
    def self.score_all(piles)
      piles.inject(0) { |total, pile| total + score(pile) }
    end

    def self.initial_deficit
      -20
    end

    def self.score(pile)
      count = pile.size

      return 0 if count.zero?

      multiplier = 1 + pile.cards.count(&:investor?)
      sum = pile.cards.map(&:value).reduce(:+)

      bonus = count >= 8 ? 20 : 0

      (sum + initial_deficit) * multiplier + bonus
    end
  end
end
