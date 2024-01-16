require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  let(:card1) { Card.new(:diamond, 'Queen', 12) }
  let(:card2) { Card.new(:spade, '3', 3) }
  let(:card3) { Card.new(:heart, 'Ace', 14) }
  let(:cards) { [card1, card2, card3] }
  let(:deck) { Deck.new(cards) }
  let(:player) { Player.new('Clarisa', deck) }

  context 'is a player that has a deck' do
    it { expect(player).to be_a Player }
    it { expect(player.name).to eq 'Clarisa' }
    it { expect(player.deck).to eq deck }
  end

  context 'instance methods' do
    it { expect(player.has_lost?).to be_falsey }
  end

  context 'player has lost when deck is empty' do
    it 'removing a card does not lose game' do
      player.deck.remove_card

      expect(player.has_lost?).to be_falsey
      expect(player.deck.cards.empty?).to be_falsey
    end

    it 'empty deck means player has lost' do
      player.deck.cards.count.times do
        player.deck.remove_card
      end

      expect(player.has_lost?).to be_truthy
      expect(player.deck.cards.empty?).to be_truthy
    end
  end
end
