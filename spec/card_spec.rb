require './lib/card'

RSpec.describe Card do
  let(:card) { Card.new(:heart, 'Jack', 11) }

  context 'is a card that has attributes' do
    it { expect(card).to be_a Card }
    it { expect(card.suit).to eq :heart }
    it { expect(card.value).to eq 'Jack' }
    it { expect(card.rank).to eq 11 }
  end
end
