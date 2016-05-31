module LostCities
  class Game
    attr_reader :players

    def initialize(player_names)
      @players = player_names.map { |name| Player.new name }
    end

    def play
      deck = DeckBuilder.build(suits)
      deck.shuffle

      piles = PileBuilder.new(suits, players).build
      hands = HandDealer.deal_to_players(players, deck)

      Round.new(players: players,
                deck: deck,
                piles: piles,
                hands: hands
               ).play
    end

    def suits
      Suit.all
    end
  end
end
