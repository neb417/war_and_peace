require './lib/card'
require './lib/deck'

RSpec.describe Deck do
  let(:card1) { Card.new(:diamond, 'Queen', 12) }
  let(:card2) { Card.new(:spade, '3', 3) }
  let(:card3) { Card.new(:heart, 'Ace', 14) }
  let(:cards) { [card1, card2, card3] }
  let(:deck) { Deck.new(cards) }

  context 'is a deck that has cards' do
    it { expect(deck).to be_a Deck }
    it { expect(deck.cards).to match_array cards }
  end

  context 'instance methods' do
    describe '#rank_of_cards' do
      it { expect(deck.rank_of_cards(0)).to eq 12 }
      it { expect(deck.rank_of_cards(2)).to eq 14 }
    end

    describe '#high_ranking_cards' do
      it { expect(deck.high_ranking_cards).to match_array [card1, card3] }
    end

    describe '#percent_high_ranking' do
      it { expect(deck.percent_high_ranking).to eq 66.67 }
    end

    describe '#remove_card' do
      it { expect(deck.remove_card).to eq card1 }

      it 'removes card from deck and adjusts high_ranking_cards and percent_high_ranking' do
        deck.remove_card

        expect(deck.high_ranking_cards).to match_array [card3]
        expect(deck.percent_high_ranking).to eq 50.0
      end
    end

    describe '#add_card' do
      let(:card4) { Card.new(:club, '5', 5) }

      it { expect(deck.add_card(card4)).to match_array [card1, card2, card3, card4] }

      it 'adds card to deck and adjusts high_ranking_cards and percent_high_ranking' do
        deck.remove_card
        deck.add_card(card4)

        expect(deck.high_ranking_cards).to match_array [card3]
        expect(deck.percent_high_ranking).to eq 33.33
      end
    end
  end
end
