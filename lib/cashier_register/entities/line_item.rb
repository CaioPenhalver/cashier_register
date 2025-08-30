# frozen_string_literal: true

require 'forwardable'

module CashierRegister
  module Entities
    class LineItem
      extend Forwardable

      attr_accessor :product, :quantity, :price

      def_delegator :@product, :code, :product_code
      def_delegator :@product, :price, :product_price

      def initialize(product:)
        @product = product
        @quantity = 0
      end

      def add_product
        self.quantity += 1
      end

      def amount
        product_price * quantity
      end
    end
  end
end
