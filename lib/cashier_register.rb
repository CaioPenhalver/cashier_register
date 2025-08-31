# frozen_string_literal: true

require 'bigdecimal'

require_relative 'cashier_register/errors/not_found_product'
require_relative 'cashier_register/entities/basket'
require_relative 'cashier_register/entities/discount'
require_relative 'cashier_register/entities/line_item'
require_relative 'cashier_register/entities/product'
require_relative 'cashier_register/infrastructure/db_adapter'
require_relative 'cashier_register/repositories/products'
require_relative 'cashier_register/services/checkout'
require_relative 'cashier_register/services/price_strategies/buy_one_get_one_free'
require_relative 'cashier_register/services/price_strategies/trhee_or_more_get_a_discount'
require_relative 'cashier_register/services/price_strategies'
require_relative 'cashier_register/services/price_rules'

module CashierRegister
end
