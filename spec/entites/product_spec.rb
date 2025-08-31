# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Entities::Product do
  let(:product) { described_class.new(code:, name:, price:) }
  let(:code) { 'SR1' }
  let(:name) { 'strawberries' }
  let(:price) { BigDecimal('5.0') }

  describe '#code' do
    subject(:code_attribute) { product.code }

    it { is_expected.to eq code }
  end

  describe '#name' do
    subject(:name_attribute) { product.name }

    it { is_expected.to eq name }
  end

  describe '#price' do
    subject(:price_attribute) { product.price }

    it { is_expected.to eq price }
  end
end
