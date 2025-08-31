# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Services::Checkout do
  let(:checkout) { described_class.new(price_rules) }
  let(:price_rules) { CashierRegister::Services::PriceRules.new }

  describe 'scan' do
    subject(:scan) { checkout.scan(code) }

    context 'when code does not exist' do
      let(:code) { 'NOT_EXIST' }

      it { expect { scan }.to raise_error(CashierRegister::Errors::NotFoundProduct) }
    end

    context 'when code exists' do
      let(:code) { 'GR1' }

      it { expect { scan }.not_to raise_error }
    end
  end

  describe '#total' do
    subject(:total) { checkout.total }

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

    context 'when eligible for all discounts' do
      let(:product_codes) { %w[GR1 CF1 SR1 CF1 CF1 GR1 SR1 SR1] }

      it { is_expected.to eq BigDecimal('39.07') }
    end
  end
end
