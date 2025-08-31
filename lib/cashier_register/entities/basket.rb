# frozen_string_literal: true

module CashierRegister
  module Entities
    class Basket
      attr_accessor :items, :discounts

      def initialize(line_item: LineItem)
        @line_item = line_item
        @items = []
        @discounts = []
      end

      def add_item(product)
        item = find_or_create_item(product)
        item.add_product
      end

      def total
        items.sum(&:amount) - discounts.sum(&:amount)
      end

      private

      attr_reader :line_item

      def find_or_create_item(product)
        item = items.find { |item| item.product_code == product.code }
        items << item = line_item.new(product:) if item.nil?
        # item || line_item.new(product:)
        item
      end
    end
  end
end
