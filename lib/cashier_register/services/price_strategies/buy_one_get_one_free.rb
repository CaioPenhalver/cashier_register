# frozen_string_literal: true

module CashierRegister
  module Services
    module PriceStrategies
      class BuyOneGetOneFree
        ELIGIBLE_PRODUCTS = ['GR1'].freeze

        def initialize(basket:, discount: Entities::Discount)
          @basket = basket
          @discount = discount
        end

        def apply
          ELIGIBLE_PRODUCTS.each do |code|
            item = basket.items.find { |item| item.product_code == code }
            next if item.nil?

            amount = calculate_discount(item)
            basket.discounts << discount.new(rule: to_s, amount:)
          end
        end

        private

        attr_reader :basket, :discount

        def calculate_discount(item)
          number_of_free_items = item.quantity / 2
          number_of_free_items * item.product_price
        end
      end
    end
  end
end
