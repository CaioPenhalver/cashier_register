# frozen_string_literal: true

module CashierRegister
  module Infrastructure
    DB_ADAPTER = {
      products: [
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
    }.freeze
  end
end
