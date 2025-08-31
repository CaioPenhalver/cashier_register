# frozen_string_literal: true

module CashierRegister
  module Errors
    class NotFoundProduct < StandardError
      def initialize
        super 'Product not found'
      end
    end
  end
end
