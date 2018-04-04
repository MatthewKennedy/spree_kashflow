module Spree
  Shipment.class_eval do
    include Spree::TaxUtil

    def to_kashflow
      {
        invoice_number: order.kashflow_number,
        quantity: 1,
        description: Spree.t(:shipping),
        rate: rate_unit.to_f,
        vat_rate: tax_rate.to_f,
        vat_amount: included_tax_total.to_f,
        charge_type: Spree::Config[:kashflow_shipping_code]
      }
    end
  end
end