# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Services::PriceStrategies::ThreeOrMoreGetADiscount do
  let(:strategy) { described_class.new(discount: discount_class) }
  let(:item) do
    instance_double(CashierRegister::Entities::LineItem,
                    product_code:,
                    quantity:,
                    amount:)
  end
  let(:basket) do
    instance_double(CashierRegister::Entities::Basket,
                    discounts: [],
                    items: [item])
  end
  let(:discount_class) { class_double(CashierRegister::Entities::Discount) }
  let(:quantity) { 0 }
  let(:amount) { BigDecimal('9.0') }

  describe '#apply' do
    subject(:apply) { strategy.apply(basket) }

    let(:discount) { instance_double(CashierRegister::Entities::Discount) }

    context 'when product is eligble' do
      shared_examples 'three or more products strategy' do
        context 'when line item has one product' do
          let(:quantity) { 1 }

          it 'does not apply discount' do
            expect(basket.discounts).not_to receive(:<<)
            apply
          end
        end

        context 'when line item has three products' do
          let(:quantity) { 3 }

          it 'applies discount' do
            expect(discount_class).to receive(:new)
              .with(rule: described_class.to_s, amount: amount_discounted)
              .and_return(discount)
            expect { apply }.to change(basket.discounts, :count).by(1)
          end
        end

        context 'when line item has four products' do
          let(:quantity) { 4 }

          it 'applies discount' do
            expect(discount_class).to receive(:new)
              .with(rule: described_class.to_s, amount: amount_discounted)
              .and_return(discount)
            expect { apply }.to change(basket.discounts, :count).by(1)
          end
        end
      end

      context 'when product has 10% discount' do
        let(:product_code) { 'SR1' }
        let(:amount_discounted) { BigDecimal('0.9') }

        it_behaves_like 'three or more products strategy'
      end

      context 'when product has 33% discount' do
        let(:product_code) { 'CF1' }
        let(:amount_discounted) { BigDecimal('3.0') }

        it_behaves_like 'three or more products strategy'
      end
    end

    context 'when item is not found' do
      let(:product_code) { 'NOT_FOUND_CODE' }

      it 'does not apply discount' do
        expect(basket.discounts).not_to receive(:<<)
        apply
      end
    end
  end
end
