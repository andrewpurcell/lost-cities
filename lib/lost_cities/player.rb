require 'text-table'

module LostCities
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      "Player #{name}"
    end

    def move(hand, piles, deck_status)
      HandPrinter.print(hand)
      DeckPrinter.print(deck_status)
      BoardPrinter.print(piles)

      move = get_move(hand)
      move.draw(get_draw_action(suits(piles))) unless deck_status.zero?

      move
    end

    def get_move(hand)
      response, match_data = nil, nil

      loop do
        puts "Which card will you play? format = (place|discard) (suit) (value)"
        response = gets
        match_data = move_regex.match(response)

        unless match_data
          puts "Couldn't parse that response."
          next
        end

        unless card = hand.find_card(Card.new(match_data['suit'], match_data['value']))
          puts "Couldn't find a card in your hand matching that description."
          next
        end

        return Move.new(match_data['action'], card)
      end
    end

    def get_draw_action(suits)
      response, match_data = nil, nil

      loop do
        puts "Where will you draw from? format = (deck|suit)"
        response = gets.chop

        unless valid_draw_actions(suits).include?(response)
          puts "That is not a valid place to draw from."
          next
        end

        return response
      end
    end

    def suits(piles)
      piles[:discard].map(&:suit)
    end

    def valid_draw_actions(suits)
       suits + ['deck']
    end

    def move_regex
      /(?<action>(discard|place)) (?<suit>(\w+)) (?<value>(\d+))/i
    end

    def draw_regex
      /(?<source>(deck|(\w+)))/i
    end

    class HandPrinter
      def self.print(hand)
        puts "## Hand ##"
        puts hand.cards.group_by(&:suit).map { |suit, cards| "#{suit}: #{cards.map(&:value).join ', '}" }
      end
    end

    class DeckPrinter
      def self.print(deck_status)
        puts "The deck has #{deck_status} cards remaining"
      end
    end

    class BoardPrinter
      def self.print(piles)
        table = Text::Table.new
        table.head = [''] + piles.values.first.map(&:suit)

        piles.each do |player, pile_list|
          table.rows << [player, *pile_list.map(&:to_inline_s)]
        end

        puts table.to_s
      end

    end
  end
end
