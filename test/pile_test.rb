require_relative 'test_helper'

describe LostCities::Pile do
  def suit
    'Egypt'
  end

  def new_suited_card(value)
    LostCities::Card.new suit, value
  end

  def new_card(suit, value)
    LostCities::Card.new suit, value
  end

  describe LostCities::Pile::DiscardPile do
    before do
      @pile = LostCities::Pile::DiscardPile.new suit
      @cards = [5, 1, 3].map { |i| new_suited_card(i) }
    end

    it 'refuses cards of the wrong suit' do
      card = new_card 'Aliens', 5

      refute @pile.can_add_card?(card)
    end

    it 'can add and draw cards in any order' do
      assert @pile.empty?
      refute @pile.can_draw?

      @cards.each do |card|
        assert @pile.can_add_card?(card)
        @pile.add card
      end

      refute @pile.empty?
      assert_equal @cards.size, @pile.size

      assert @pile.can_draw?

      popped = @cards.size.times.map { @pile.draw }
      assert_equal @cards.reverse, popped

      assert @pile.empty?
    end
  end

  describe LostCities::Pile::PlayerPile do
    before do
      @pile = LostCities::Pile::PlayerPile.new suit
      @one, @two, @three = [1,2,3].map { |i| new_suited_card i }
    end

    it 'can add cards in order' do
      @pile.add @two

      assert @pile.can_add_card?(@three)
      refute @pile.can_add_card?(@one)
    end

    it 'cannot draw' do
      @pile.add @one

      refute @pile.can_draw?
      assert_raises(StandardError) { @pile.draw }
    end
  end
end
