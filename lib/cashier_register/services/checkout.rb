# frozen_string_literal: true

module CashierRegister
  module Services
    class Checkout
      def initialize(price_rules_service, basket: Entities::Basket.new, products_repository: Repositories::Products.new)
        @price_rules_service = price_rules_service
        @basket = basket
        @products_repository = products_repository
      end

      def scan(product_code)
        product = products_repository.find_by(code: product_code)
        basket.add_item(product)
      end

      def total
        price_rules_service.apply(basket)
        basket.total
      end

      private

      attr_reader :price_rules_service, :basket, :products_repository
    end
  end
end
