# frozen_string_literal: true

module CashierRegister
  module Services
    module PriceStrategies
      class ThreeOrMoreGetADiscount
        ELIGIBLE_PRODUCTS = {
          'SR1' => BigDecimal('0.1'),
          'CF1' => BigDecimal('0.33333')
        }.freeze

        def initialize(basket:, discount: Entities::Discount)
          @basket = basket
          @discount = discount
        end

        def apply
          ELIGIBLE_PRODUCTS.each do |code, percentage_discount|
            item = basket.items.find { |item| item.product_code == code }
            next if item.nil?

            amount = calculate_discount(item, percentage_discount)
            next if amount.zero?

            basket.discounts << discount.new(rule: self.class.to_s, amount:)
          end
        end

        private

        attr_reader :basket, :discount

        def calculate_discount(item, percentage_discount)
          return BigDecimal('0') if item.quantity < 3

          (item.amount * percentage_discount).ceil(2)
        end
      end
    end
  end
end
