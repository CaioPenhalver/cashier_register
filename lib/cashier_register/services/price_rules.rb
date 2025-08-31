# frozen_string_literal: true

module CashierRegister
  module Services
    class PriceRules
      def initialize(rules: PriceStrategies::RULES)
        @rules = rules
      end

      def apply(basket)
        rules.each { |rule| rule.apply(basket) }
      end

      private

      attr_reader :rules
    end
  end
end
