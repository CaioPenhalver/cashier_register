# frozen_string_literal: true

module CashierRegister
  module Entities
    class Discount
      attr_reader :rule, :amount

      def initialize(rule:, amount:)
        @rule = rule
        @amount = amount
      end
    end
  end
end
