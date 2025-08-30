# frozen_string_literal: true

module CashierRegister
  module Entities
    class Product
      attr_accessor :code, :name, :price

      def initialize(code:, name:, price:)
        @code = code
        @name = name
        @price = price
      end
    end
  end
end
