module Spree
  Payment.class_eval do
    def to_kashflow
      {
        pay_invoice: order.kashflow_number,
        pay_amount: amount.to_f
      }
    end
  end
end