module LostCities
  class Round
    attr_reader :players, :deck, :hands, :piles
    attr_accessor :move_count

    def initialize(players:, deck:, hands:, piles:, move_count: 0)
      @players = players
      @deck = deck
      @hands = hands
      @piles = piles
      @move_count = move_count
    end

    def round_finished?
      deck.empty? && both_players_have_moved?
    end

    def both_players_have_moved?
      @move_count.even?
    end

    def calculate_scores
      players.map do |player|
        [player, PileScorer.score_all(piles[player])]
      end.to_h
    end

    def declare_winner(scores)
      scores.each do |player, score|
        puts "#{player} had a score of #{score}."
      end

      winner = scores.max_by { |player, score| score }.first
      puts "#{winner} wins."
    end

    def get_valid_move(player)
      move = nil

      loop do
        move = player.move(hands[player], piles, deck.cards_remaining)
        return move if legal_move?(move, player)

        puts "Illegal move."
      end
    end

    def pile_for_move(move, player)
      pile_list = move.discard? ? piles[:discard] : piles[player]
      pile_list.find { |pile| pile.suit == move.card.suit }
    end

    def pile_for_draw(move)
      piles[:discard].find { |pile| pile.suit == move.draw_from }
    end

    def draw_source(move)
      move.draw_from_deck? ? deck : pile_for_draw(move)
    end

    def apply_move_rules(move, player)
      return false unless hands[player].has_card? move.card

      return false unless pile_for_move(move, player).can_add_card? move.card

      true
    end

    def apply_draw_rules(move, player)
      return true if deck.empty?

      return false unless move.draw_from_deck? || pile_for_draw(move).can_draw?

      true
    end

    def legal_move?(move, player)
      return false unless apply_move_rules(move, player)
      return false unless apply_draw_rules(move, player)

      true
    end

    def play_move(player, move)
      hands[player].remove(move.card)
      pile_for_move(move, player).add(move.card)
      hands[player].add(draw_source(move).draw)
    end

    def play
      players.cycle do |player|
        puts "It is #{player}'s move"
        move = get_valid_move(player)
        play_move(player, move)

        @move_count += 1

        break if round_finished?
      end

      scores = calculate_scores
      declare_winner(scores)
    end

  end
end
