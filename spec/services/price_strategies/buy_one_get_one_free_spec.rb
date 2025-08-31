require 'spec_helper'

RSpec.describe CashierRegister::Services::PriceStrategies::BuyOneGetOneFree do
  let(:strategy) { described_class.new(basket:, discount: discount_class) }
  let(:item) do
    instance_double(CashierRegister::Entities::LineItem,
                    product_code:,
                    quantity:,
                    product_price:)
  end
  let(:basket) do
    instance_double(CashierRegister::Entities::Basket,
                    discounts: [],
                    items: [item])
  end
  let(:discount_class) { class_double(CashierRegister::Entities::Discount) }
  let(:quantity) { 0 }
  let(:product_price) { BigDecimal('3.0') }

  describe '#apply' do
    subject(:apply) { strategy.apply }

    let(:discount) { instance_double(CashierRegister::Entities::Discount) }

    context 'when product is eligble' do
      let(:product_code) { 'GR1' }

      context 'when line item has one product' do
        let(:quantity) { 1 }

        it 'does not apply discount' do
          expect(basket.discounts).not_to receive(:<<)
          apply
        end
      end

      shared_examples 'get free item strategy' do
        it 'applies discount' do
          expect(discount_class).to receive(:new)
            .with(rule: described_class.to_s, amount: amount_discounted)
            .and_return(discount)
          expect { apply }.to change(basket.discounts, :count).by(1)
        end
      end

      context 'when line item has two products' do
        let(:quantity) { 2 }
        let(:amount_discounted) { product_price }

        it_behaves_like 'get free item strategy'
      end

      context 'when line item has three products' do
        let(:quantity) { 3 }
        let(:amount_discounted) { product_price }

        it_behaves_like 'get free item strategy'
      end

      context 'when line item has four products' do
        let(:quantity) { 4 }
        let(:amount_discounted) { product_price * 2 }

        it_behaves_like 'get free item strategy'
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
