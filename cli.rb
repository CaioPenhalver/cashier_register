# frozen_string_literal: true

require_relative 'lib/cashier_register'

module Cli
  def self.call
    cashier_register = CashierRegister::Services::Checkout.new(
      CashierRegister::Services::PriceRules.new
    )
    puts 'Add product code below: '
    product_codes = gets.chomp
    return 0 if product_codes.empty?

    product_codes.split(' ').each do |code|
      cashier_register.scan code
    end

    puts "Total: #{cashier_register.total.to_s('F')}"
  end
end

Cli.call
