# frozen_string_literal: true

module CashierRegister
  module Services
    module PriceStrategies
      RULES = [
        BuyOneGetOneFree.new,
        ThreeOrMoreGetADiscount.new
      ].freeze
    end
  end
end
