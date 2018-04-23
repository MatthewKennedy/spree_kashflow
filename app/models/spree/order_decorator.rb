module Spree
  Order.class_eval do
    state_machine.after_transition to: :complete, do: :send_order_kashflow

    def send_order_kashflow
      OrderKashflowJob.perform_later(self)
    end

    def customer_to_kashflow
      {
        name: bill_address.full_name,
        telephone: bill_address.phone,
        email: email,
        address1: bill_address.address1,
        address2: bill_address.address2,
        address3: bill_address.city,
        address4: bill_address.state.to_s,
        postcode: bill_address.zipcode,
        country_name: bill_address.country.to_s,
     if bill_address.country.iso.present?
        country_code: bill_address.country.iso
      else
        country_code: bill_address.country.iso_name
     end
      }
    end

    def ship_address_to_kashflow
      {
        name: ship_address.full_name,
        line1: ship_address.address1,
        line2: ship_address.address2,
        line3: ship_address.city,
        line4: ship_address.state.to_s,
        postcode: ship_address.zipcode,
        country_name: ship_address.country.to_s,
     if ship_address.country.iso.present?
        country_code: ship_address.country.iso
      else
        country_code: ship_address.country.iso_name
     end
      }
    end

    # delivery address is sent, but isn't showed on kashflow invoice page until set "Use different delivery address" on address
    def to_kashflow
      {
        invoice_date: completed_at.iso8601,
        customer_reference: Spree.t(:kashflow_customer_reference, number: number),
        currency_code: currency,
        paid: paid? ? 1 : 0,
        amount_paid: total.to_f,
        delivery_address: ship_address_to_kashflow,
        use_custom_delivery_address: !shipping_eq_billing_address?
      }
    end
  end
end