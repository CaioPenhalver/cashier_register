# frozen_string_literal: true

module CashierRegister
  module Repositories
    class Products
      def initialize(product: Entities::Product, db_adapter: Infrastructure::DB_ADAPTER)
        @product = product
        @db_adapter = db_adapter
      end

      def find_by(code:)
        record = db_adapter[:products].find { |product| product[:code] == code }
        return nil if record.nil?

        product.new(**record)
      end

      private

      attr_reader :product, :db_adapter
    end
  end
end
