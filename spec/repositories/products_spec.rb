require 'spec_helper'

RSpec.describe CashierRegister::Repositories::Products do
  let(:products_repository) { described_class.new(product: product_class, db_adapter:) }
  let(:product_class) { class_double(CashierRegister::Entities::Product) }
  let(:product) { instance_double(CashierRegister::Entities::Product) }
  let(:code) { 'PRODUCT_CODE' }
  let(:name) { 'Product name' }
  let(:price) { BigDecimal('1.0') }
  let(:db_adapter) do
    {
      products: [
        { code:, name:, price: }
      ]
    }
  end

  describe '#find_by' do
    subject(:find_by) { products_repository.find_by(code: search_code) }

    context 'when product exists' do
      let(:search_code) { code }

      before do
        allow(product_class).to receive(:new)
          .with(code:, name:, price:).and_return(product)
      end

      it { is_expected.to eq product }
    end

    context 'when product is not found' do
      let(:search_code) { 'NOT_EXISTENT_CODE' }

      it { is_expected.to be_nil }
    end
  end
end
