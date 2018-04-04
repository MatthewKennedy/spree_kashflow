class CreateItems
  include Interactor

  def call
    context.order.line_items.each do |item|
      context.client.insert_invoice_line_with_invoice_number(transform(item.to_kashflow))
    end

    context.order.shipments.each do |shipment|
      context.client.insert_invoice_line_with_invoice_number(transform(shipment.to_kashflow))
    end

    context.order.shipment_adjustments.additional.each do |adjustment|
      context.client.insert_invoice_line_with_invoice_number(transform(adjustment.to_kashflow))
    end

    context.order.adjustments.additional.each do |adjustment|
      context.client.insert_invoice_line_with_invoice_number(transform(adjustment.to_kashflow))
    end
  end

  def transform(object)
    if context.order.currency == context.default_currency.currency_code
      return object
    end

    object[:values_in_currency] = 1
    object
  end
end