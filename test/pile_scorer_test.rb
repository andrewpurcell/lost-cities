require_relative 'test_helper'

describe LostCities::PileScorer do
  before do
    @suit = 'egypt'
    @pile = LostCities::Pile.new @suit
    @scorer = LostCities::PileScorer

    @investor = LostCities::Card.new @suit, 0, true
    @cards = (0..10).to_a.map { |value| LostCities::Card.new @suit, value }
  end

  it "doesn't score an empty pile" do
    assert_equal 0, @scorer.score(@pile)
  end

  it 'adds a multiplier' do
    @pile.add @investor
    @pile.add @cards[10]

    assert_equal ((-20 + 10) * 2), @scorer.score(@pile)
  end

  it 'adds a bonus after the multipler' do
    range = 3..10

    @pile.add @investor
    @cards[range].each { |card| @pile.add card }

    assert_equal ((range.reduce(:+) - 20) * 2)  + 20, @scorer.score(@pile)
  end
end
