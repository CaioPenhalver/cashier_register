# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CashierRegister::Services::PriceRules do
  let(:price_rule) { described_class.new(rules:) }

  describe '.apply' do
    subject(:apply) { price_rule.apply(basket) }

    let(:basket) { instance_double(CashierRegister::Entities::Basket) }
    let(:get_free_item_rule) { instance_double(CashierRegister::Services::PriceStrategies::BuyOneGetOneFree) }
    let(:get_discount_rule) { instance_double(CashierRegister::Services::PriceStrategies::ThreeOrMoreGetADiscount) }
    let(:rules) do
      [
        get_free_item_rule,
        get_discount_rule
      ]
    end

    it 'applies price rules' do
      expect(get_free_item_rule).to receive(:apply).with(basket)
      expect(get_discount_rule).to receive(:apply).with(basket)
      apply
    end
  end
end
