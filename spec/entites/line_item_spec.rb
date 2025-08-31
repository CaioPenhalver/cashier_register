require 'spec_helper'

RSpec.describe CashierRegister::Entities::LineItem do
  let(:line_item) { described_class.new(product:) }
  let(:product) { instance_double(CashierRegister::Entities::Product) }

  describe '#prodcut' do
    subject(:product_attribute) { line_item.product }

    it { is_expected.to eq product }
  end

  describe '#product_code' do
    subject(:product_code_attribute) { line_item.product_code }

    let(:product_code) { 'GR1' }

    before { allow(product).to receive(:code).and_return(product_code) }

    it { is_expected.to eq product_code }
  end

  describe '#product_price' do
    subject(:product_price_attribute) { line_item.product_price }

    let(:product_price) { BigDecimal('4.0') }

    before { allow(product).to receive(:price).and_return(product_price) }

    it { is_expected.to eq product_price }
  end

  describe '#add_product' do
    subject(:add_product) do
      product_number.times { line_item.add_product }
    end

    context 'when one product has been added' do
      let(:product_number) { 1 }

      it { is_expected.to eq product_number }
    end

    context 'when 5 products have been added' do
      let(:product_number) { 5 }

      it { is_expected.to eq product_number }
    end
  end

  describe '#amount' do
    subject(:amount_attribute) { line_item.amount }

    let(:product_price) { BigDecimal('4.0') }

    before { allow(product).to receive(:price).and_return(product_price) }

    context 'when no product has been added' do
      it { is_expected.to be_zero }
    end

    context 'when one product has been added' do
      before { line_item.add_product }

      it { is_expected.to eq product_price }
    end

    context 'when three products have been added' do
      let(:number_of_items) { 3 }

      before { number_of_items.times { line_item.add_product } }

      it { is_expected.to eq(product_price * number_of_items) }
    end
  end
end
