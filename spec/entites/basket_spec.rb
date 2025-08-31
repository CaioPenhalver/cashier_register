# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Entities::Basket do
  let(:basket) { described_class.new(line_item: line_item_class) }
  let(:line_item_class) { class_double(CashierRegister::Entities::LineItem) }

  describe '#items' do
    subject(:items_attribute) { basket.items }

    it { is_expected.to eq [] }
  end

  describe '#discounts' do
    subject(:discounts_attribute) { basket.discounts }

    it { is_expected.to eq [] }
  end

  describe '#add_item' do
    subject(:add_item) { basket.add_item(product) }

    let(:product) { instance_double(CashierRegister::Entities::Product, code: product_code) }
    let(:line_item) { instance_double(CashierRegister::Entities::LineItem, product_code:, add_product: nil) }
    let(:product_code) { 'GR1' }

    context 'when the product has not been added into the basket' do
      it 'creates a new line item with product' do
        expect(line_item_class).to receive(:new).with(product:).and_return(line_item)
        expect(line_item).to receive(:add_product)
        expect { add_item }.to change(basket.items, :count).from(0).to(1)
      end
    end

    context 'when the product has been already added into the basket' do
      before { basket.items << line_item }

      it 'increases the number of products' do
        expect(line_item).to receive(:add_product)
        expect { add_item }.not_to change(basket.items, :count)
      end
    end
  end

  describe '#total' do
    subject(:product_price_attribute) { basket.total }

    let(:items) do
      [
        instance_double(CashierRegister::Entities::LineItem, amount: BigDecimal('5.5')),
        instance_double(CashierRegister::Entities::LineItem, amount: BigDecimal('10.5'))
      ]
    end

    before { basket.items = items }

    it { is_expected.to eq BigDecimal('16.0') }

    context 'when there are discounts applied' do
      let(:discounts) do
        [
          instance_double(CashierRegister::Entities::Discount, amount: BigDecimal('1.5')),
          instance_double(CashierRegister::Entities::Discount, amount: BigDecimal('2.5'))
        ]
      end

      before { basket.discounts = discounts }

      it { is_expected.to eq BigDecimal('12.0') }
    end
  end
end
