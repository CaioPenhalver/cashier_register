# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Entities::Discount do
  let(:discount) { described_class.new(rule:, amount:) }
  let(:rule) { 'PriceStrategyName' }
  let(:amount) { BigDecimal('5.0') }

  describe '#rule' do
    subject(:rule_attribute) { discount.rule }

    it { is_expected.to eq rule }
  end

  describe '#amount' do
    subject(:amount_attribute) { discount.amount }

    it { is_expected.to eq amount }
  end
end
