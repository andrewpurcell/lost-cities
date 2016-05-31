module LostCities
  class Pile
    attr_reader :cards, :suit

    class DiscardPile < Pile
      def can_draw?
        !empty?
      end

      def draw
        raise 'Empty pile!' if empty?

        cards.pop
      end
    end

    class PlayerPile < Pile
      def can_add_card?(card)
        super && card >= cards.last
      end

      def can_draw?
        false
      end

      def draw
        raise "Can't draw from a player's pile."
      end
    end

    def initialize(suit)
      @cards = []
      @suit = suit
    end

    def empty?
      cards.empty?
    end

    def size
      cards.size
    end

    def can_add_card?(card)
      card.suit == suit
    end

    def add(card)
      cards.push(card) if can_add_card?(card)
    end

    def draw
      raise NotImplementedError
    end

    def can_draw?
      raise NotImplementedError
    end

    def to_inline_s
      cards.map(&:value).join(', ')
    end
  end
end
