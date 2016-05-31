module LostCities
  class Move
    attr_reader :card, :action, :draw_from

    def initialize(action, card)
      @action, @card = action, card
    end

    def discard?
      action == 'discard'
    end

    def draw_from_deck?
      draw_from == 'deck'
    end

    def draw(source)
      @draw_from = source
    end
  end
end
