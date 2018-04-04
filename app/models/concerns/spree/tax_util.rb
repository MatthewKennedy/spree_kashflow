module Spree
  module TaxUtil
    extend ActiveSupport::Concern

    included do
      def tax_rate
        (included_tax_total / pre_tax_amount).round(2, BigDecimal::ROUND_HALF_UP) * 100
      rescue ZeroDivisionError
        0.0
      end

      def rate_unit
        if respond_to?(:quantity)
          pre_tax_amount / quantity
        else
          pre_tax_amount
        end
      rescue ZeroDivisionError
        pre_tax_amount / 1
      end
    end
  end
end
