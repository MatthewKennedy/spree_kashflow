module Spree
  LineItem.class_eval do
    include Spree::TaxUtil

    def to_kashflow
      {
        invoice_number: order.kashflow_number,
        quantity: quantity,
        description: [variant.name, variant.options_text].join(" "),
        rate: rate_unit.to_f,
        vat_rate: tax_rate.to_f,
        vat_amount: included_tax_total.to_f,
        charge_type: Spree::Config[:kashflow_sale_of_goods_code]
      }
    end
  end
end