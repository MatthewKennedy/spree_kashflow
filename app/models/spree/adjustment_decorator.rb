module Spree
  Adjustment.class_eval do
    def to_kashflow
      {
        invoice_number: order.kashflow_number,
        quantity: 1,
        description: label,
        rate: amount.to_f
      }
    end
  end
end