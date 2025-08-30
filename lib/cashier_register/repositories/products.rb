# frozen_string_literal: true

module CashierRegister
  module Repositories
    class Products
      def initialize(product: Entities::Product)
        @product = product
      end

      def find_by(code:)
        record = database_products_table.find { |product| product[:code] == code }
        return nil if record.nil?

        product.new(**record)
      end

      private

      attr_reader :product

      def database_products_table
        [
          {
            code: 'GR1',
            name: 'Green tea',
            price: BigDecimal('3.11')
          },
          {
            code: 'SR1',
            name: 'Strawberries',
            price: BigDecimal('5.00')
          },
          {
            code: 'CF1',
            name: 'Coffee',
            price: BigDecimal('11.23')
          }
        ]
      end
    end
  end
end
