require_relative 'test_helper'

describe LostCities do
  describe LostCities::DeckBuilder do
    before do
      @cards = LostCities::DeckBuilder.build_cards(LostCities::Suit.all, 2..10, 3)
    end

    it 'includes the right stuff' do
      assert_equal 5*12, @cards.count
      assert_equal 5*3, @cards.count(&:investor?)
    end
  end

  def new_card(suit, value)
    LostCities::Card.value_card suit, value
  end

  describe LostCities::Card do
    it 'can be compared' do
      small_card = new_card 'Egypt', 2
      big_card = new_card 'Egypt', 6
      different_suit = new_card 'Amazon', 6

      assert big_card >= small_card
      assert big_card >= nil
      refute big_card == different_suit
    end
  end

  describe LostCities::Hand do
    def new_hand(*args)
      LostCities::Hand.new args
    end

    before do
      @hand = new_hand(new_card('Egypt', 5), new_card('Egypt', 6), new_card('Amazon', 5))
    end

    let(:other_card) { new_card 'Amazon', 6 }

    it 'can add and remove cards' do
      refute @hand.full?, 'Hand should not be full'

      @hand.add other_card

      assert_equal 4, @hand.size

      @hand.remove other_card

      assert_equal 3, @hand.size

    end
  end
end
