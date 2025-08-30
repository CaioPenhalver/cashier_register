# frozen_string_literal: true

module CashierRegister
  module Services
    class PriceRules
      PRICE_STRATEGIES = [
        PriceStrategies::BuyOneGetOneFree,
        PriceStrategies::ThreeOrMoreGetADiscount
      ].freeze

      class << self
        def apply(basket)
          PRICE_STRATEGIES.each { |rule| rule.new(basket:).apply }
        end
      end
    end
  end
end
