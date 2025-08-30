# frozen_string_literal: true

RSpec.describe CashierRegister::Services::Checkout do
  describe '#total' do
    subject(:checkout) { described_class.new(price_rules).total }

    let(:rules) { double('PriceRules') }

    before do
      product_codes.each { |code| checkout.scan(code) }
    end

    context 'when buy-one-get-one-free offers is eligible for green tea' do
      let(:product_codes) { %w[GR1 GR1] }

      it { is_expected.to eq BigDecimal('3.11') }

      context 'when there are other products' do
        let(:product_codes) { %w[GR1 SR1 GR1 GR1 CF1] }

        it { is_expected.to eq BigDecimal('22.45') }
      end
    end

    context 'when price discount is eligible for strawberries' do
      let(:product_codes) { %w[SR1 SR1 GR1 SR1] }

      it { is_expected.to eq BigDecimal('16.61') }
    end

    context 'when price drop is eligible for coffee' do
      let(:product_codes) { %w[GR1 CF1 SR1 CF1 CF1] }

      it { is_expected.to eq BigDecimal('30.57') }
    end
  end
end
